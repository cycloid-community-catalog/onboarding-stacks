# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# Infra
variable "kubernetes_version" {
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region."
  default     = "1.30"
}

variable "resource_group_name" {
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