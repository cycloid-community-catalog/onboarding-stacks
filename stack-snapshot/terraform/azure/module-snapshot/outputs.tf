output "vm_private_ip" {
  description = "The private IP address the Snapshot server"
  value       = azurerm_linux_virtual_machine.snapshot.private_ip_address
}

output "vm_public_ip" {
  description = "The public IP address the Snapshot server"
  value       = azurerm_linux_virtual_machine.snapshot.public_ip_address
}