# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}
variable "api_url" {}
variable "api_key" {}

# Cloud variables
variable "azure_cred" {
  description = "The azure credential used to deploy the infrastructure. It contains subscription_id, tenant_id, client_id, and client_secret"
}