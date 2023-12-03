# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# Keypair
variable "keypair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
}


#
# OWASP Zed Attack Proxy (ZAP)
#
variable "vm_machine_type" {
  description = "Machine type for the OWASP Zed Attack Proxy (ZAP)"
  default     = "n2-standard-2"
}

variable "vm_os_user" {
  description = "Admin username to connect to instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

variable "vm_disk_size" {
  description = "Disk size for the OWASP Zed Attack Proxy (ZAP) (Go)"
  default = "20"
}

variable "zap_port" {
  description = "Port where OWASP Zed Attack Proxy (ZAP) service is exposed"
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