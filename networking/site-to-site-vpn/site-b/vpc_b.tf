# Simulate Corporate Network
module "vpc_b" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.18.1"
  name            = "VPC-B"
  cidr            = var.vpc_cidr
  azs             = var.vpc_azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags = {
    Name        = "VPC-B"
    Terraform   = "true"
    Environment = "dev"
  }
}

# Add a route to the private route table to say all traffic to the VPC A (aws side)
# need to be routed to the EC2 B (which is acting as the router in this exercise)
resource "aws_route" "vpn_through_router" {
  route_table_id         = element(module.vpc_b.private_route_table_ids, 0)
  destination_cidr_block = var.vpc_a_cidr
  network_interface_id   = module.ec2_b.primary_network_interface_id
}
