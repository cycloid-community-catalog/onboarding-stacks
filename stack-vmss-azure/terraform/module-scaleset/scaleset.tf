# Create Network Security Group and Rules
resource "azurerm_network_security_group" "web" {
  name                = "${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

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
    name                       = "inbound-webapp"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}-vmss"
  })
}

# Create Azure VM Scale Set with cloud-init script
resource "azurerm_linux_virtual_machine_scale_set" "web" {
  name                = "${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = var.vmss_instance_type
  instances           = var.vmss_instances # number of instances

  overprovision          = false
  single_placement_group = false

  admin_username      = var.vm_os_user
  admin_password      = random_password.pwd.result

  disable_password_authentication = false

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadOnly"

    diff_disk_settings {
      option = "Local"
    }
  }

  custom_data = base64encode(templatefile(
    "${path.module}/userdata-node.sh.tpl",
    {
      redis_host = azurerm_linux_virtual_machine.redis.private_ip_address
      redis_port = 6379
      node_port = 8080
    }
  ))

  network_interface {
    name    = "${var.project}-${var.env}"
    primary = true
    network_security_group_id = azurerm_network_security_group.web.id

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id]
    }
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}"
    role = "scaleset"
  })
}