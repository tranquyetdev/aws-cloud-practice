resource "aws_security_group" "ec2_b_sg" {
  name   = "ec2_b_sg"
  vpc_id = module.vpc_b.vpc_id

  tags = {
    Name = "ec2_b_sg"
  }
}

resource "aws_security_group_rule" "icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.vpc_a_cidr]
  security_group_id = aws_security_group.ec2_b_sg.id
}

resource "aws_security_group_rule" "ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.myipv4]
  security_group_id = aws_security_group.ec2_b_sg.id
}

resource "aws_security_group_rule" "ec2_b_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_b_sg.id
}


resource "aws_security_group_rule" "ec2_b_allow_icmp_internal_sgr" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.ec2_b_sg.id
}

resource "aws_security_group_rule" "ec2_b_allow_tcp_internal_sgr" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.ec2_b_sg.id
}
