# VPC A
variable "vpc_cidr" {
  type        = string
  description = "The CIDR to use for the VPC."
}

variable "region" {
  type        = string
  description = "The region into which to deploy the VPC."
}

variable "vpc_azs" {
  type        = list(string)
  description = "The availability zones for which to add subnets."
}

variable "private_subnets" {
  type        = list(string)
  description = "The CIDR of the private subnets"
}

# VPC B
variable "vpc_b_cidr" {
  type        = string
  description = "The CIDR to use for the VPC B (Coporate Network)."
}

variable "cgw_ip" {
  type        = string
  description = "The public IP address of the VPC B router (the EC2 that is running Openswan)."
}
