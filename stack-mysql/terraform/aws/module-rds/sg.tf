resource "aws_security_group" "rds" {
  name        = "${var.cyorg}-${var.cyproject}-${var.cyenv}-${var.cycomp}"
  description = "${var.cyproject} ${var.cyenv} ${var.cycomp}"
  vpc_id      = aws_subnet.selected.vpc_id

  tags = {
    Name = "${var.cyorg}-${var.cyproject}-${var.cyenv}-${var.cycomp}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "mysql" {
  security_group_id = aws_security_group.rds.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"

  referenced_security_group_id = aws_security_group.app_selected.id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.rds.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

data "aws_security_group" "app_selected" {
  id = var.app_security_group_id
}