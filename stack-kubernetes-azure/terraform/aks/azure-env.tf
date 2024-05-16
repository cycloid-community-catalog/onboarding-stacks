# set up env vars for post-installation to work via the Azure CLI
resource "null_resource" "env-cred" {
  provisioner "local-exec" {
    command = "env"
    environment = {
      ARM_SUBSCRIPTION_ID = var.azure_cred.subscription_id
      ARM_TENANT_ID = var.azure_cred.tenant_id
      ARM_CLIENT_ID = var.azure_cred.client_id
      ARM_CLIENT_SECRET = var.azure_cred.client_secret
    }
  }
}