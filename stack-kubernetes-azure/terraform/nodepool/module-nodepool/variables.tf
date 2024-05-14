# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# Infra
variable "kubernetes_cluster_id" {
  description = "The existing Azure Kubernetes cluster (AKS) where the nodepool will be deployed."
  default     = ""
}

variable "nodepool_vm_size" {
  description = "The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
  default     = "Standard_DS2_v2"
}

variable "nodepool_node_count" {
  description = "The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 (inclusive) for user pools and between 1 and 1000 (inclusive) for system pools and must be a value in the range min_count - max_count."
  default     = 1
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