output "zulip_url" {
  description = "The URL of the Zulip UI"
  value       = "http://${module.zulip.vm_ip}:${module.zulip.zulip_port}"
}

output "vm_ip" {
  description = "The IP address the Zulip server"
  value       = module.zulip.vm_ip
}

output "zulip_port" {
  description = "Port where Zulip service is exposed"
  value       = module.zulip.zulip_port
}

output "vm_os_user" {
  description = "The username to use to connect to the Zulip instance via SSH."
  value       = module.zulip.vm_os_user
}