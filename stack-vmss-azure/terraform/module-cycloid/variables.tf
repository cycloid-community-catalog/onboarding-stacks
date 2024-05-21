# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "vm_os_user" {
  description = "Admin username to connect to instances. 'admin' is not allowed by Azure."
  default     = "cycloid"
}

variable "vm_password" {
  description = "User password to connect to instances."
  default     = "Standard_DS2_v2"
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid" = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}