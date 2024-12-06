resource "azurerm_role_assignment" "role_assignment" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Reader"
  principal_id         = azurerm_linux_function_app.linux_function_app.identity.0.principal_id
}