# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to create"
  default     = "cycloid"
}

variable "azure_location" {
  description = "Azure location where to create resources"
  default = "West Europe"
}

variable "network_cidr" {
  type        = string
  description = "The CIDR of the Virtual Network."
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "The CIDR for the Subnet."
  default     = "10.0.0.0/24"
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