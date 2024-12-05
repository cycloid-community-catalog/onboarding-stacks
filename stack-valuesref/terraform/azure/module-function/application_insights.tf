resource "azurerm_application_insights" "application_insights" {
  name                = "${var.cyorg}-${var.cyproject}-${var.cyenv}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = var.azure_location
  application_type    = "other"

  tags = merge(local.merged_tags, {
    Name = "${var.cyorg}-${var.cyproject}-${var.cyenv}"
    role = "application_insights"
  })
}
