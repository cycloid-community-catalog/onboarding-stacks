#
# Resource Group outputs
#
output "resource_group_name" {
  description = "The name for the Resource Group"
  value       = data.azurerm_resource_group.compute.name
}

#
# vNet outputs
#
output "vnet_name" {
  description = "The name for the virtual network"
  value       = data.azurerm_virtual_network.selected.name
}

#
# Instance outputs
#
output "vm_ip" {
  description = "The IP address the EC2 instance"
  value       = azurerm_linux_virtual_machine.compute.public_ip_address
}

output "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = var.vm_os_user
}