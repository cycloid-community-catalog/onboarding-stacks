output "vm_private_dns" {
  description = "Private DNS name assigned to the instance"
  value       = aws_instance.snapshot.private_dns
}

output "vm_public_ip" {
  description = "Public IP address assigned to the instance"
  value       = aws_instance.snapshot.public_ip
}