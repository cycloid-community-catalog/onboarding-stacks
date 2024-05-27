resource "azurerm_linux_virtual_machine" "redis" {
  name                  = "${var.project}-${var.env}-redis"
  computer_name         = "${var.project}-${var.env}-redis"
  location              = data.azurerm_resource_group.rg.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.redis.id]
  size                  = var.redis_instance_type
  
  admin_username      = var.vm_os_user
  admin_password      = random_password.pwd.result

  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.redis_disk_size
  }

  source_image_reference {
      publisher = "Debian"
      offer     = "debian-11"
      sku       = "11"
      version   = "latest"
  }

  custom_data = base64encode(file("${path.module}/userdata-redis.sh.tpl"))

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}-redis"
    role = "redis"
  })
}

# Create Network Security Group and Rules
resource "azurerm_network_security_group" "redis" {
  name                = "${var.project}-${var.env}-redis"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

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
    name                       = "inbound-redis"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6379"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}-redis"
    role = "inbound-redis"
  })
}

# Create Network Card for the VM
resource "azurerm_network_interface" "redis" {
  name                = "${var.project}-${var.env}-redis"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
      name                          = "${var.project}-${var.env}-redis"
      subnet_id                     = var.subnet_id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = azurerm_public_ip.redispublicip.id
  }

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}-redis"
    role = "network_interface"
  })
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "redis" {
    network_interface_id      = azurerm_network_interface.redis.id
    network_security_group_id = azurerm_network_security_group.redis.id
}

resource "azurerm_public_ip" "redispublicip" {
  name                = "${var.project}-${var.env}-redis-ip"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku = "Standard"

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}"
    role = "public_ip"
  })
}
