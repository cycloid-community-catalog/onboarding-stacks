resource "aws_security_group" "zap" {
  name        = "${var.customer}-${var.project}-${var.env}-zap"
  description = "Allow accessing the OWASP Zed Attack Proxy (ZAP) service from the internet."
  vpc_id      = var.vpc_id

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}-zap"
  })
}

resource "aws_security_group_rule" "egress-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.zap.id
}

resource "aws_security_group_rule" "self" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  self              = true
  security_group_id = aws_security_group.zap.id
}

resource "aws_security_group_rule" "ingress-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.zap.id
}

resource "aws_security_group_rule" "ingress-zap" {
  type              = "ingress"
  from_port         = var.zap_port
  to_port           = var.zap_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.zap.id
}


resource "aws_instance" "zap" {
  ami           = data.aws_ami.debian.id
  instance_type = var.vm_instance_type
  key_name      = var.key_pair_name

  vpc_security_group_ids = [aws_security_group.zap.id]

  subnet_id               = data.aws_subnets.public_subnets.ids[0]
  disable_api_termination = false
  # associate_public_ip_address = true

  root_block_device {
    volume_size           = var.vm_disk_size
    delete_on_termination = true
  }

  user_data_base64 = base64encode(templatefile(
    "${path.module}/userdata.sh.tpl",
    {
      zap_port = var.zap_port
    }
  ))

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}-zap"
    role       = "zap"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}