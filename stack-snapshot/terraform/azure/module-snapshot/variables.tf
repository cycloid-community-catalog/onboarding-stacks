# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "azure_location" {
  description = "Azure location"
  default = "West Europe"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the existing resource group where the resources will be deployed."
  default     = "cycloid-get-started"
}

variable "vm_instance_type" {
  description = "Instance type for the Snapshot"
  default     = "Standard_DS1_v2"
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