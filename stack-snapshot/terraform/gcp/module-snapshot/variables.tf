# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# Subnet
variable "subnet_self_link" {
  description = "The GCP subnet self link where to deploy the instances"
}

variable "vm_machine_type" {
  description = "Machine type for the Snapshot"
  default     = "n2-standard-2"
}

variable "vm_disk_size" {
  description = "Disk size for the Snapshot (Go)"
  default = "20"
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid"    = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}