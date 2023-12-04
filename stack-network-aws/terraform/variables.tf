# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

# AWS variables
variable "aws_cred" {
  description = "Contains AWS access_key and secret_key"
}
variable "aws_region" {
  description = "AWS region where to create servers."
  default     = "eu-west-1"
}
variable "bastion" {
  description = "Whether to deploy a bastion instance or not."
  default     = false
}
variable "keypair_public" {}