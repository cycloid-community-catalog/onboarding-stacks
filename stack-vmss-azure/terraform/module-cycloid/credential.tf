resource "cycloid_credential" "redis" {
  name = "${var.project}-${var.env}-redis"
  path = "${var.project}-${var.env}-redis"
  type = "basic_auth"
  body = {
    username = var.vm_os_user
    password = var.vm_password
  }
}
