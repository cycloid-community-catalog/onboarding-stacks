output "vm_ip" {
  description = "The IP address the OWASP Zed Attack Proxy (ZAP) EC2 server"
  value       = google_compute_instance.zap.network_interface.0.access_config.0.nat_ip
}

output "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = var.vm_os_user
}

output "zap_port" {
  description = "Port where OWASP Zed Attack Proxy (ZAP) service is exposed"
  value       = var.zap_port
}