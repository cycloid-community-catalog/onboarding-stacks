module "aks" {
  source                 = "Azure/aks/azurerm"
  version                = "8.0.0"
  resource_group_name    = data.azurerm_resource_group.aks.name
  kubernetes_version     = var.kubernetes_version
  orchestrator_version   = var.kubernetes_version
  sku_tier               = var.kubernetes_sku_tier
  prefix                 = "${var.project}-${var.env}"
  network_plugin         = "azure"
  rbac_aad               = false
}