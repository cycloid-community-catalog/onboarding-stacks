resource "aws_db_instance" "db" {
  identifier              = "${var.cyorg}-${var.cyproject}-${var.cyenv}-${var.cycomp}"
  apply_immediately       = true
  backup_window           = "02:00-04:00"
  maintenance_window      = "tue:06:00-tue:07:00"
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  engine                  = "mysql"
  engine_version          = "${var.rds_engine_version}"
  instance_class          = "${var.rds_instance_class}"
  multi_az                = false
  parameter_group_name    = aws_db_parameter_group.rds-optimized.name
  storage_type            = "gp3"
  allocated_storage       = 10
  snapshot_identifier     = var.rds_snapshot_identifier == "" ? null : var.rds_snapshot_identifier
  username                = "${var.cyproject}-${var.cyenv}-${var.cycomp}"
  password                = random_password.rds
  vpc_security_group_ids  = ["${aws_security_group.rds.id}"]
}