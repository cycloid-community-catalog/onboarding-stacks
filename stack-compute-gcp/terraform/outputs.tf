#
# VPC outputs
#
output "vpc_name" {
  description = "The name for the VPC"
  value       = module.compute.vpc_name
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