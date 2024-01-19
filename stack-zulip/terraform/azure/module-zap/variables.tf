# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# Key pair
variable "key_pair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
}

variable "azure_location" {
  description = "Azure location"
  default = "West Europe"
}


#
# OWASP Zed Attack Proxy (ZAP)
#
variable "resource_group_name" {
  type        = string
  description = "The name of the existing resource group where the resources will be deployed."
  default     = "cycloid-get-started"
}

variable "vm_instance_type" {
  description = "Instance type for the OWASP Zed Attack Proxy (ZAP)"
  default     = "Standard_DS1_v2"
}

variable "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  default     = "zap"
}

variable "vm_disk_size" {
  description = "Disk size for the OWASP Zed Attack Proxy (ZAP) (Go)"
  default = "20"
}

variable "zap_port" {
  description = "Port where zap OWASP Zed Attack Proxy (ZAP) is exposed"
  default = "8080"
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