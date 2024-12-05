resource "azurerm_role_assignment" "role_assignment" {
  scope                = "/subscriptions/508f906f-b287-4882-b038-c653fe001aa0"
  role_definition_name = "Reader"
  principal_id         = azurerm_linux_function_app.linux_function_app.identity.0.principal_id
}