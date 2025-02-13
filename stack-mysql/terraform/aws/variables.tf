# Cycloid variables
variable "cycomp" {}
variable "cyenv" {}
variable "cyproject" {}
variable "cyorg" {}

# AWS variables
variable "aws_cred" {
  description = "Contains AWS access_key and secret_key"
}

variable "aws_region" {
  description = "AWS region where to create servers."
  default     = "eu-west-1"
}

variable "cycloid_api_url" {
  type        = string
  description = "Cycloid API endpoint"
}

variable "cyorg_jwt" {
  type        = string
  description = "Org JWT used for authentication"
  sensitive   = true
}
