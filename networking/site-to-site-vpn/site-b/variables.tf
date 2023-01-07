variable "region" {
  type        = string
  description = "The region into which to deploy the VPC."
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR to use for the VPC."
}

variable "vpc_azs" {
  type        = list(string)
  description = "The availability zones for which to add subnets."
}

variable "public_subnets" {
  type        = list(string)
  description = "The CIDR of the public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "The CIDR of the private subnets"
}

variable "ec2_b_ip" {
  type        = string
  description = "The static public IP for EC2 B"
  default     = ""
}

variable "myipv4" {
  type        = string
  description = "My IPV4 for SSH connection to EC2 B"
}

variable "mypublic_key" {
  type        = string
  description = "My IPV4 for SSH connection to EC2 B"
}

# VPC A
variable "vpc_a_cidr" {
  type        = string
  description = "The CIDR to use for the VPC A"
}

variable "vpc_a_tunnel_1_ip" {
  type        = string
  description = "The public IP address of the VPN tunnel 1"
}

variable "preshared_key" {
  type        = string
  description = "The preshared key of the VPN tunnel"
}
