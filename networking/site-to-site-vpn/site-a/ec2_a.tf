data "aws_key_pair" "aws_cloud_pratice" {
  key_name = "aws-cloud-pratice"
}

data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-*-hvm-*-x86_64-gp2"]
  }
}

module "ec2_a" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "EC2-A"

  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.aws_cloud_pratice.key_name
  availability_zone      = element(module.vpc_a.azs, 0)
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ec2_a_sg.id]
  subnet_id              = element(module.vpc_a.private_subnets, 0)
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
