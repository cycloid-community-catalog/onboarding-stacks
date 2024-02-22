output "snapshot_private_url" {
  description = "The private URL of the Snapshot UI"
  value       = "http://${module.snapshot.vm_private_ip}"
}

output "snapshot_public_url" {
  description = "The public URL of the Snapshot UI"
  value       = "http://${module.snapshot.vm_public_ip}"
}
