# Cycloid variables
variable "cyenv" {}
variable "cyproject" {}
variable "cyorg" {}

# AWS variables
variable "aws_cred" {
  description = "Contains AWS access_key and secret_key"
  sensitive   = true
}
variable "aws_region" {
  description = "AWS region where to create servers."
  default     = "us-east-1"
}