resource "aws_key_pair" "aws_cloud_pratice" {
  key_name   = "aws-cloud-pratice"
  public_key = var.mypublic_key
}

data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-*-hvm-*-x86_64-gp2"]
  }
}

# Use an Elastic IP address for the EC2 B to avoid the public IP changed every time
# we update the user data
resource "aws_eip" "ec2_b_ip" {
  instance = module.ec2_b.id
  vpc      = true
}

module "ec2_b" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  name = "EC2-B"

  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.aws_cloud_pratice.key_name
  availability_zone      = element(module.vpc_b.azs, 0)
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.ec2_b_sg.id]
  subnet_id              = element(module.vpc_b.public_subnets, 0)

  # Important to bypass security group check for this router
  # so that the traffic is able to flow through
  source_dest_check = false

  # Automate set up the OpenSwan via user data
  user_data_replace_on_change = true
  user_data = templatefile("./templates/ec2_b_user_data.tftpl", {
    leftid        = var.ec2_b_ip,
    right         = var.vpc_a_tunnel_1_ip
    leftsubnet    = var.vpc_cidr
    rightsubnet   = var.vpc_a_cidr
    preshared_key = var.preshared_key
  })

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
