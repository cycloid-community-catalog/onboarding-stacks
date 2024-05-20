resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}"
    role = "virtual_network"
  })
}