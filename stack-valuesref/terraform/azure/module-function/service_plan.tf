resource "azurerm_service_plan" "service_plan" {
  name                = "${var.cyorg}-${var.cyproject}-${var.cyenv}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = var.azure_location
  os_type             = "Linux"
  sku_name            = var.service_plan_sku_name

  tags = merge(local.merged_tags, {
    Name = "${var.cyorg}-${var.cyproject}-${var.cyenv}"
    role = "app_service_plan"
  })
}