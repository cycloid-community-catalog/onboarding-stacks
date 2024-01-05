# Cycloid
variable "customer" {}
variable "project" {}
variable "env" {}

#
# OWASP Zed Attack Proxy (ZAP)
#
variable "vm_instance_type" {
  description = "Instance type for the OWASP Zed Attack Proxy (ZAP)"
  default     = "t3.small"
}

variable "vm_disk_size" {
  description = "Disk size for the OWASP Zed Attack Proxy (ZAP) (Go)"
  default = "20"
}

variable "zap_port" {
  description = "Port where OWASP Zed Attack Proxy (ZAP) service is exposed"
  default = "8080"
}

variable "vpc_id" {
  description = "VPC ID where to deploy the EC2 instance"
}

variable "key_pair_name" {
  description = "Public Key pair name to provision to the EC2 instance"
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