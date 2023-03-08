#
# Resource Group outputs
#
output "rg_name" {
  description = "The name for the Resource Group"
  value       = module.webapp.rg_name
}

#
# vNet outputs
#
output "vnet_name" {
  description = "The name for the virtual network"
  value       = module.webapp.vnet_name
}

#
# Instance outputs
#
output "vm_ssh" {
  description = "The SSH address to connect to the instance"
  value       = "${module.webapp.vm_os_user}@${module.webapp.vm_ip}"
}

output "url" {
  description = "The URL of the wepapp"
  value       = "http://${module.webapp.vm_ip}"
}