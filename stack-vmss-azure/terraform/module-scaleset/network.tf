resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}"
    role = "virtual_network"
  })
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.project}-${var.env}"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.rg.name
  address_prefixes     = ["10.0.1.0/24"]
}
