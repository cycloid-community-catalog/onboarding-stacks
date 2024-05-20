resource "azurerm_redis_cache" "redis" {
  name                = "${var.project}-${var.env}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  capacity            = 1
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = true

  redis_configuration {
    enable_authentication = false
    maxmemory_policy   = "allkeys-lru"
  }
}