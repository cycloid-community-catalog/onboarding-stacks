resource "azurerm_service_plan" "service_plan" {
  name                = "${var.customer}-${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = var.azure_location
  os_type             = "Linux"
  sku_name            = "B1"

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "app_service_plan"
  })
}