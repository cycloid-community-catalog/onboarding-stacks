resource "azurerm_storage_account" "storage_account" {
  name = "cycloid${var.project}${var.env}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location = var.azure_location
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "storage_account"
  })
}
