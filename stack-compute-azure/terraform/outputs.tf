#
# Resource Group outputs
#
output "resource_group_name" {
  description = "The name for the Resource Group"
  value       = module.compute.resource_group_name
}

#
# vNet outputs
#
output "vnet_name" {
  description = "The name for the virtual network"
  value       = module.compute.vnet_name
}

#
# Instance outputs
#
output "vm_ssh" {
  description = "The SSH address to connect to the instance"
  value       = "${module.compute.vm_os_user}@${module.compute.vm_ip}"
}

output "url" {
  description = "The URL of the wepapp"
  value       = "http://${module.compute.vm_ip}"
}