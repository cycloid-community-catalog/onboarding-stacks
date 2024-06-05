# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "s3_bucket_name" {
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name."
}

variable "s3_force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
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