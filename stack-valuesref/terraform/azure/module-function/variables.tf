# Cycloid
variable "cyorg" {}
variable "cyenv" {}
variable "cyproject" {}

variable "subscription_id" {
  type        = string
  description = "The subscription ID that will be queried. This is to create the correct role to the function attached identity."
  default     = ""
}

variable "resource_group_name" {
  type        = string
  description = "The name of the existing resource group where the resources will be deployed."
  default     = ""
}

variable "azure_location" {
  description = "Azure location"
  default = "West Europe"
}

variable "python_version" {
  description = "Python version"
  default = "3.11"
}

variable "service_plan_sku_name" {
  description = "Service plan SKU name."
  default = "Y1"
}


# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid" = "true"
    env          = var.cyenv
    project      = var.cyproject
    customer     = var.cyorg
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}
