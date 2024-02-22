# Create Network Security Group
resource "azurerm_network_security_group" "snapshot" {
  name                = "${var.customer}-${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.snapshot.name
  location            = var.azure_location

  security_rule {
    name                       = "inbound-snapshot"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
  })
}

# Create Network Card for the VM
resource "azurerm_network_interface" "snapshot" {
  name                = "${var.customer}-${var.project}-${var.env}-snapshot"
  resource_group_name = data.azurerm_resource_group.snapshot.name
  location            = var.azure_location

  ip_configuration {
      name                          = "${var.customer}-${var.project}-${var.env}"
      subnet_id                     = azurerm_subnet.snapshot.id
      private_ip_address_allocation = "Dynamic"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
  })
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "snapshot" {
    network_interface_id      = azurerm_network_interface.snapshot.id
    network_security_group_id = azurerm_network_security_group.snapshot.id
}

resource "azurerm_virtual_network" "snapshot" {
  name                = "${var.customer}-${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.snapshot.name
  location            = var.azure_location
  address_space       = ["10.123.0.0/16"]

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
  })
}

resource "azurerm_subnet" "snapshot" {
  name                 = "${var.customer}-${var.project}-${var.env}"
  virtual_network_name = azurerm_virtual_network.snapshot.name
  resource_group_name  = data.azurerm_resource_group.snapshot.name

  address_prefixes     = ["10.123.1.0/24"]
}