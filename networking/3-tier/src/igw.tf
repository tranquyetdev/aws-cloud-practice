resource "aws_internet_gateway" "base_igw" {
  vpc_id = aws_vpc.base.id

  tags = {
    Name                 = "${var.deployment_identifier}-${var.component}-igw"
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
    Tier                 = "public"
  }
}
