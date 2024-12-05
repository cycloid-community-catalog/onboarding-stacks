data "azurerm_subscription" "primary" {
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = "/subscriptions/${data.azurerm_subscription.primary.id}/resourceGroups/${data.azurerm_resource_group.resource_group.name}"
  role_definition_name = "Reader"
  principal_id         = azurerm_linux_function_app.linux_function_app.identity.0.principal_id
}