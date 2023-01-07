resource "aws_security_group" "ec2_a_sg" {
  name        = "ec2_a_sg"
  description = "Allow TCP inbound traffic from VPC B"
  vpc_id      = module.vpc_a.vpc_id

  tags = {
    Name = "ec2_a_sg"
  }
}

resource "aws_security_group_rule" "ingress_vpc_b_cidr" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_b_cidr]
  security_group_id = aws_security_group.ec2_a_sg.id
}

resource "aws_security_group_rule" "ingress_vpc_b_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.vpc_b_cidr]
  security_group_id = aws_security_group.ec2_a_sg.id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_a_sg.id
}
