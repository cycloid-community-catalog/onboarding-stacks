resource "azurerm_linux_function_app" "linux_function_app" {
  name                = "${var.customer}-${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = var.azure_location

  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  service_plan_id            = azurerm_service_plan.service_plan.id
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = 1,
    "FUNCTIONS_WORKER_RUNTIME" = "node",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.application_insights.instrumentation_key,
  }

  zip_deploy_file = data.archive_file.function_package.output_path
  site_config {
    application_insights_key               = azurerm_application_insights.application_insights.instrumentation_key
    application_insights_connection_string = azurerm_application_insights.application_insights.connection_string
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "function_app"
  })

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}
