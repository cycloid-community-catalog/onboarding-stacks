# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

# Cloud variables
variable "azure_cred" {
  description = "The azure credential used to deploy the infrastructure. It contains subscription_id, tenant_id, client_id, and client_secret"
}

variable "git_func_url" {
  description = "The git repository URL where the azure function to deploy is located."
}

variable "git_func_branch" {
  description = "The git repository branch where the azure function to deploy is located."
}

variable "git_func_path" {
  description = "The git repository path where the azure function to deploy is located. Can be blank if the function is in the root directory."
}
