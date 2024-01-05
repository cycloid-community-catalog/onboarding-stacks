output "vm_ip" {
  description = "The IP address the OWASP Zed Attack Proxy (ZAP) EC2 server"
  value       = aws_instance.zap.public_ip
}

output "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = "admin"
}

output "zap_port" {
  description = "Port where OWASP Zed Attack Proxy (ZAP) service is exposed"
  value = var.zap_port
}