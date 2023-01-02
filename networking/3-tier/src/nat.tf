resource "aws_eip" "nat" {
  count = local.include_nat_gateways == "yes" ? length(var.availability_zones) : 0

  vpc = true

  tags = {
    Name                 = "${var.deployment_identifier}-${var.component}-eip-nat-${count.index}",
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
  }
}

resource "aws_nat_gateway" "base" {
  count = local.include_nat_gateways == "yes" ? length(var.availability_zones) : 0

  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  depends_on = [
    aws_internet_gateway.base_igw
  ]

  tags = {
    Name                 = "${var.deployment_identifier}-${var.component}-nat-${count.index}"
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
  }
}
