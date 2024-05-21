# LB Public IP
output "web_lb_public_ip_address" {
  description = "Web Load Balancer Public Address"
  value = azurerm_public_ip.lbpublicip.ip_address
}

# Load Balancer ID
output "web_lb_id" {
  description = "Web Load Balancer ID."
  value = azurerm_lb.web_lb.id 
}

# Load Balancer Frontend IP Configuration Block
output "web_lb_frontend_ip_configuration" {
  description = "Web LB frontend_ip_configuration Block"
  value = [azurerm_lb.web_lb.frontend_ip_configuration]
}

# User name to access the VMs
output "vm_user" {
  description = "User name to access the VMs"
  value = var.vm_os_user
  sensitive = true
}

# User password to access the VMs
output "vm_password" {
  description = "User password to access the VMs"
  value = random_password.pwd.result
  sensitive = true
}

# The Hostname of the Redis Instance
output "redis_host" {
  description = "The private IP address of the Redis Instance."
  value = azurerm_linux_virtual_machine.redis.private_ip_address
}