resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "${var.customer}-${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = var.azure_location
  kind                = "FunctionApp"
  reserved = true # this has to be set to true for Linux. Not related to the Premium Plan
  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "app_service_plan"
  })
}
