#
# VPC outputs
#
output "vpc_name" {
  description = "The name for the VPC"
  value       = data.google_compute_network.selected.name
}

#
# Instance outputs
#
output "vm_ip" {
  description = "The IP address the instance"
  value       = google_compute_instance.compute.network_interface.0.access_config.0.nat_ip
}

output "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = var.vm_os_user
}