variable "organization" {}
variable "project" {}
variable "env" {}

# Terraform Amazon Web Services provider configuration
# See: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  access_key = var.aws_cred.access_key
  secret_key = var.aws_cred.secret_key
  region     = var.aws_region

  default_tags { # The default_tags block applies tags to all resources managed by this provider, except for the Auto Scaling groups (ASG).
    tags = {
      "cycloid.io" = "true"
      env          = var.env
      project      = var.project
      organization = var.organization
    }
  }
}

variable "aws_cred" {} # { access_key, secret_key }

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-1"
}

