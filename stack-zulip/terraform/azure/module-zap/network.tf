# Create Network Security Group
resource "azurerm_network_security_group" "zap" {
  name                = "${var.customer}-${var.project}-${var.env}-zap"
  resource_group_name = data.azurerm_resource_group.zap.name
  location            = var.azure_location

  security_rule {
    name                       = "inbound-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "inbound-zap"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.zap_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-zap"
  })
}

# Get a Static Public IP
resource "azurerm_public_ip" "zap" {
  name                = "${var.customer}-${var.project}-${var.env}-zap"
  resource_group_name = data.azurerm_resource_group.zap.name
  location            = var.azure_location
  allocation_method   = "Dynamic"

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-zap"
  })
}

# Create Network Card for the VM
resource "azurerm_network_interface" "zap" {
  name                = "${var.customer}-${var.project}-${var.env}-zap"
  resource_group_name = data.azurerm_resource_group.zap.name
  location            = var.azure_location

  ip_configuration {
      name                          = "${var.customer}-${var.project}-${var.env}-zap"
      subnet_id                     = azurerm_subnet.zap.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = azurerm_public_ip.zap.id
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-zap"
  })
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "zap" {
    network_interface_id      = azurerm_network_interface.zap.id
    network_security_group_id = azurerm_network_security_group.zap.id
}

resource "azurerm_virtual_network" "zap" {
  name                = "${var.customer}-${var.project}-${var.env}-zap"
  resource_group_name = data.azurerm_resource_group.zap.name
  location            = var.azure_location
  address_space       = ["10.123.0.0/16"]

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-zap"
  })
}

resource "azurerm_subnet" "zap" {
  name                 = "${var.customer}-${var.project}-${var.env}-zap"
  virtual_network_name = azurerm_virtual_network.zap.name
  resource_group_name  = data.azurerm_resource_group.zap.name

  address_prefixes     = ["10.123.1.0/24"]
}