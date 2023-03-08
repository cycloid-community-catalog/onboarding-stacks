# Create Nexus VM
resource "azurerm_linux_virtual_machine" "nexus" {
  name                  = "${var.customer}-${var.project}-${var.env}-nexus"
  computer_name         = "nexus"
  resource_group_name   = data.azurerm_resource_group.nexus.name
  location              = data.azurerm_resource_group.nexus.location
  network_interface_ids = [azurerm_network_interface.nexus.id]
  size                  = var.vm_instance_type
  admin_username        = var.vm_os_user

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.vm_disk_size
  }

  source_image_reference {
      publisher = "credativ"
      offer     = "Debian"
      sku       = "9"
      version   = "latest"
  }

  disable_password_authentication = true

  admin_ssh_key {
      username   = var.vm_os_user
      public_key = var.keypair_public
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-nexus"
    role = "nexus"
  })
}