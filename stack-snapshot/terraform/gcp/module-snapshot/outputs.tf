output "vm_private_ip" {
  description = "The private IP address the Snapshot server"
  value       = google_compute_instance.snapshot.network_interface.0.network_ip
}

output "vm_public_ip" {
  description = "The public IP address the Snapshot server"
  value       = google_compute_instance.snapshot.network_interface.0.access_config.0.nat_ip
}