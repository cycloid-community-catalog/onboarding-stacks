# Create zap VM
resource "azurerm_linux_virtual_machine" "zap" {
  name                  = "${var.customer}-${var.project}-${var.env}-zap"
  computer_name         = "zap"
  resource_group_name   = data.azurerm_resource_group.zap.name
  location              = var.azure_location
  network_interface_ids = [azurerm_network_interface.zap.id]
  size                  = var.vm_instance_type
  admin_username        = var.vm_os_user

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.vm_disk_size
  }

  source_image_reference {
      publisher = "Debian"
      offer     = "debian-11"
      sku       = "11"
      version   = "latest"
  }

  disable_password_authentication = true

  admin_ssh_key {
      username   = var.vm_os_user
      public_key = var.key_pair_public
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-zap"
    role = "zap"
  })
}