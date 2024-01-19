output "vm_ip" {
  description = "The IP address the OWASP Zed Attack Proxy (ZAP) EC2 server"
  value       = aws_instance.zap.public_ip
}

output "zulip_port" {
  description = "Port where the Zulip service is exposed"
  value = var.zulip_port
}

output "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = "admin"
}