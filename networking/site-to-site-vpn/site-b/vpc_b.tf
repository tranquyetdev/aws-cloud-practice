# Simulate Corporate Network
module "vpc_b" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "3.18.1"
  name           = "VPC-B"
  cidr           = var.vpc_cidr
  azs            = var.vpc_azs
  public_subnets = var.public_subnets
  tags = {
    Name        = "VPC-B"
    Terraform   = "true"
    Environment = "dev"
  }
}
