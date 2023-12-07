resource "aws_key_pair" "webapp" {
  key_name   = "${var.customer}-${var.project}-${var.env}-webapp"
  public_key = var.key_pair_public
}