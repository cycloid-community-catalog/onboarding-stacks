# Create snapshot VM
resource "azurerm_linux_virtual_machine" "snapshot" {
  name                  = "${var.customer}-${var.project}-${var.env}"
  computer_name         = "${var.customer}-${var.project}-${var.env}"
  resource_group_name   = data.azurerm_resource_group.snapshot.name
  location              = var.azure_location
  network_interface_ids = [azurerm_network_interface.snapshot.id]
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

  custom_data = base64encode(templatefile(
    "${path.module}/userdata.sh.tpl",
    {
      # project = var.project
      # env = var.env
    }
  ))

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "snapshot"
  })
}