# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "resource_group_name" {
  type        = string
  description = "The name of the existing resource group where the resources will be deployed."
  default     = ""
}

variable "azure_location" {
  description = "Azure location"
  default = "West Europe"
}

variable "git_func_package" {
  description = "Git repository path where the azure function package (zip file) is stored"
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
