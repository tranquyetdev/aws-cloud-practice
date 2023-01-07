resource "aws_security_group" "ec2_c_sg" {
  name   = "ec2_c_sg"
  vpc_id = module.vpc_b.vpc_id

  tags = {
    Name = "ec2_c_sg"
  }
}

resource "aws_security_group_rule" "ec2_c_ingress_icmp_sgr" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.ec2_c_sg.id
}

resource "aws_security_group_rule" "ec2_c_ingress_ssh_sgr" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.ec2_c_sg.id
}

resource "aws_security_group_rule" "ec2_c_egress_sgr" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_c_sg.id
}
