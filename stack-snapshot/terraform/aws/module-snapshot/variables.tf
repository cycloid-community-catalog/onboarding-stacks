# Cycloid
variable "customer" {}
variable "project" {}
variable "env" {}


variable "vm_instance_type" {
  description = "Instance type for the Snapshot"
  default     = "t3.small"
}

variable "vm_disk_size" {
  description = "Disk size for the Snapshot (Go)"
  default = "20"
}

variable "subnet_id" {
  description = "Subnet ID where to deploy the EC2 instance"
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid"    = "true"
    customer     = var.customer
    project      = var.project
    env          = var.env
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}