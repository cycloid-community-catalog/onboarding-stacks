#
# VPC outputs
#
output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = module.webapp.vpc_id
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