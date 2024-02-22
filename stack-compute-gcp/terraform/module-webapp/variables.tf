# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# Infra
variable "vm_machine_type" {
  description = "Machine type for the Nexus Repository"
  default     = "n2-standard-2"
}

variable "vm_disk_size" {
  description = "Disk size for the instance (Go)"
  default = "20"
}

variable "vm_os_user" {
  description = "Admin username to connect to instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

variable "key_pair_public" {
  description = "Public key to provision to the instance"
  default = ""
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