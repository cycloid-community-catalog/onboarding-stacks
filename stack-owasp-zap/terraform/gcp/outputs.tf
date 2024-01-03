output "zap_url" {
  description = "The URL of the OWASP Zed Attack Proxy UI"
  value       = "http://${module.zap.vm_ip}:${module.zap.port}/UI"
}

output "vm_ip" {
  description = "The IP address the OWASP Zed Attack Proxy (ZAP)"
  value       = module.zap.vm_ip
}

output "port" {
  description = "Port where OWASP Zed Attack Proxy (ZAP) service is exposed"
  value       = module.zap.port
}

output "vm_os_user" {
  description = "The username to use to connect to the OWASP Zed Attack Proxy (ZAP) instance via SSH."
  value       = module.zap.vm_os_user
}