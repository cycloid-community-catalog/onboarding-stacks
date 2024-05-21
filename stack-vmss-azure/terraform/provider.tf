provider "azurerm" {
  features {}
  client_id       = var.azure_cred.client_id
  client_secret   = var.azure_cred.client_secret
  subscription_id = var.azure_cred.subscription_id
  tenant_id       = var.azure_cred.tenant_id
  environment     = "public"
}

provider "cycloid" {
  url                    = var.api_url
  jwt                    = var.api_key
  organization_canonical = var.customer
}