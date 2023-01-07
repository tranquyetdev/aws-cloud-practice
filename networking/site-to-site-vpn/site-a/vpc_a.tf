module "vpn_gateway" {
  source  = "terraform-aws-modules/vpn-gateway/aws"
  version = "~> 2.0"

  vpc_id              = module.vpc_a.vpc_id
  vpn_gateway_id      = module.vpc_a.vgw_id
  customer_gateway_id = module.vpc_a.cgw_ids[0]

  # In this example, we use static routing, so we put the CIDR of the Coporate network here
  vpn_connection_static_routes_only         = true
  vpn_connection_static_routes_destinations = [var.vpc_b_cidr]
  vpc_subnet_route_table_count              = length(var.private_subnets)
  vpc_subnet_route_table_ids                = module.vpc_a.private_route_table_ids
}

# AWS Side VPC
module "vpc_a" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.18.1"
  name            = "VPC-A"
  cidr            = var.vpc_cidr
  azs             = var.vpc_azs
  private_subnets = var.private_subnets

  enable_vpn_gateway = true

  customer_gateways = {
    IP1 = {
      bgp_asn = 65000
      # This is the public IP address of the EC2 instance that is running OpenSwan
      ip_address = var.cgw_ip
    }
  }

  tags = {
    Name        = "VPC-A"
    Terraform   = "true"
    Environment = "dev"
  }
}
