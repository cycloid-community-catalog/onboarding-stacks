#
# VPC outputs
#
output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = google_compute_network.webapp.id
}

#
# Instance outputs
#
output "vm_ip" {
  description = "The IP address the instance"
  value       = google_compute_instance.webapp.network_interface.0.access_config.0.nat_ip
}

output "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = var.vm_os_user
}