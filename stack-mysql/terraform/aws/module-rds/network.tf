data "aws_subnet" "selected" {
  id = var.rds_subnet_id
}