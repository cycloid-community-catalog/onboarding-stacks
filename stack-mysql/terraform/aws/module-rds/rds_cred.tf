resource "cycloid_credential" "rds" {
  name                   = "${var.cyproject}-${var.cyenv}-${var.cycomp}"
  description            = "Username and password to connect to the RDS database."
  organization_canonical = var.cyorg
  path                   = "${var.cyproject}-${var.cyenv}-${var.cycomp}"
  canonical              = "${var.cyproject}-${var.cyenv}-${var.cycomp}"

  type = "basic_auth"
  body = {
    username = aws_db_instance.db.username
    password = random_password.rds
  }
}