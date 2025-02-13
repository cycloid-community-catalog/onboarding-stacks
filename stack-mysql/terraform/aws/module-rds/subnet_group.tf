resource "aws_db_subnet_group" "rds" {
  name       = "main"
  subnet_ids = [var.rds_subnet_id]

  tags = {
    Name = "My DB subnet group"
  }
}