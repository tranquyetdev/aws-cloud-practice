module "ec2_c" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  name = "EC2-C"

  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.aws_cloud_pratice.key_name
  availability_zone      = element(module.vpc_b.azs, 0)
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.ec2_c_sg.id]
  subnet_id              = element(module.vpc_b.private_subnets, 0)

  user_data_replace_on_change = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
