resource "aws_vpc" "base" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name                 = "${var.deployment_identifier}-${var.component}-vpc"
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
    Dependencies         = join(",", local.dependencies)
  }
}
