resource "aws_security_group" "snapshot" {
  name        = "${var.customer}-${var.project}-${var.env}"
  description = "Allow accessing the snapshot service from the internet."
  vpc_id      = data.aws_subnet.selected.vpc_id

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
  security_group_id = aws_security_group.snapshot.id
}

resource "aws_security_group_rule" "self" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  self              = true
  security_group_id = aws_security_group.snapshot.id
}

resource "aws_security_group_rule" "ingress-snapshot" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.snapshot.id
}


resource "aws_instance" "snapshot" {
  ami           = data.aws_ami.debian.id
  instance_type = var.vm_instance_type

  vpc_security_group_ids = [aws_security_group.snapshot.id]

  subnet_id               = var.subnet_id
  disable_api_termination = false

  root_block_device {
    volume_size           = var.vm_disk_size
    delete_on_termination = true
  }

  user_data_base64 = base64encode(templatefile(
    "${path.module}/userdata.sh.tpl",
    {
      # project = var.project
      # env = var.env
    }
  ))

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}"
    role       = "snapshot"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}