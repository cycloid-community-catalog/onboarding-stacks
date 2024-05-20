# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# Infra
variable "vmss_instance_type" {
  description = "The Virtual Machine SKU for the Scale Set, such as Standard_DS2_v2."
  default     = "Standard_DS2_v2"
}

variable "vmss_instances" {
  description = "The number of Virtual Machines in the Scale Set."
  default = "1"
}

variable "vm_os_user" {
  description = "Admin username to connect to instance. 'admin' is not allowed by Azure."
  default     = "cycloid"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the existing resource group where the resources will be deployed."
  default     = ""
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