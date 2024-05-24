resource "cycloid_credential" "pwd" {
  name = "${var.project}-${var.env}"
  path = "${var.project}-${var.env}"
  type = "basic_auth"
  body = {
    username = var.vm_os_user
    password = var.vm_password
  }
}
