resource "azurerm_storage_account" "storage_account" {
  name = "cycloid${var.cyproject}${var.cyenv}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location = var.azure_location
  account_kind = "Storage"
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = merge(local.merged_tags, {
    Name = "${var.cyorg}-${var.cyproject}-${var.cyenv}"
    role = "storage_account"
  })
}