data "azurerm_subscription" "primary" {
}

data "azurerm_system_assigned_identity" "system_assigned_identity" {
  name                = azurerm_linux_function_app.linux_function_app.identity.0.name
  resource_group_name = azurerm_linux_function_app.linux_function_app.resource_group_name
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_system_assigned_identity.system_assigned_identity.principal_id
}