resource "azurerm_linux_function_app" "linux_function_app" {
  name                = "${var.customer}-${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = var.azure_location

  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  service_plan_id            = azurerm_service_plan.service_plan.id
  https_only                 = true
  
  app_settings = {
    "ENABLE_ORYX_BUILD" = "true"
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "FUNCTIONS_WORKER_RUNTIME" = "python"
    # WEBSITE_RUN_FROM_PACKAGE = "https://${azurerm_storage_account.storage_account.name}.blob.core.windows.net/${azurerm_storage_container.storage_container.name}/${azurerm_storage_blob.storage_blob.name}"
    # WEBSITE_RUN_FROM_PACKAGE = "https://${azurerm_storage_account.storage_account.name}.blob.core.windows.net/${azurerm_storage_container.storage_container.name}/${azurerm_storage_blob.storage_blob.name}${data.azurerm_storage_account_sas.storage_account_sas.sas}"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.application_insights.instrumentation_key,
  }

  site_config {
    # application_insights_key               = azurerm_application_insights.application_insights.instrumentation_key
    # application_insights_connection_string = azurerm_application_insights.application_insights.connection_string
    application_stack {
      # node_version = "18"
      python_version = "3.11"
    }
  }

  zip_deploy_file = data.archive_file.function_package.output_path

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "function_app"
  })
}