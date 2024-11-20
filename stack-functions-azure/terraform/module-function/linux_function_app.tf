resource "azurerm_linux_function_app" "linux_function_app" {
  name                = "${var.customer}-${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = var.azure_location

  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  service_plan_id            = azurerm_service_plan.service_plan.id
  https_only                 = false
  version                    = "~4"

  app_settings = {
    AzureWebJobsStorage = azurerm_storage_account.storage_account.primary_connection_string
    AzureWebJobsFeatureFlags = "EnableWorkerIndexing"
    FUNCTIONS_WORKER_RUNTIME = "python"
    WEBSITE_RUN_FROM_PACKAGE = 1
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key
  }

  site_config {
    application_stack {
      python_version = var.python_version
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "function_app"
  })
}
