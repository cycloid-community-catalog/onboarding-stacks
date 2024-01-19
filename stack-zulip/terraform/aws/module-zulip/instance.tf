resource "aws_security_group" "zulip" {
  name        = "${var.customer}-${var.project}-${var.env}"
  description = "Allow accessing the Zulip service from the internet."
  vpc_id      = var.vpc_id

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}"
  })
}

resource "aws_security_group_rule" "egress-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.zulip.id
}

resource "aws_security_group_rule" "self" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  self              = true
  security_group_id = aws_security_group.zulip.id
}

resource "aws_security_group_rule" "ingress-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.zulip.id
}

resource "aws_security_group_rule" "ingress-zulip" {
  type              = "ingress"
  from_port         = var.zulip_port
  to_port           = var.zulip_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.zulip.id
}


resource "aws_instance" "zulip" {
  ami           = data.aws_ami.debian.id
  instance_type = var.vm_instance_type
  key_name      = var.key_pair_name

  vpc_security_group_ids = [aws_security_group.zulip.id]

  subnet_id               = data.aws_subnets.public_subnets.ids[0]
  disable_api_termination = false
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.vm_disk_size
    delete_on_termination = true
  }

  user_data_base64 = base64encode(templatefile(
    "${path.module}/userdata.sh.tpl",
    {
      zulip_email = var.zulip_email
      # zulip_subdomain = var.zulip_subdomain
      # zulip_domain = var.zulip_domain
      # project = var.project
      # env = var.env
      # cycloid_api_key = var.cycloid_api_key
    }
  ))

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}"
    role       = "zulip"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}