output "vm_ip" {
  description = "The IP address the OWASP Zed Attack Proxy (ZAP) server"
  value       = azurerm_linux_virtual_machine.zap.public_ip_address
}

output "vm_name" {
  description = "The vm name the OWASP Zed Attack Proxy (ZAP) server"
  value       = azurerm_linux_virtual_machine.zap.name
}

output "zap_port" {
  description = "Port where OWASP Zed Attack Proxy (ZAP) service is exposed"
  value = var.zap_port
}

output "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = var.vm_os_user
}