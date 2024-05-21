# LB Public IP
output "web_lb_public_ip_address" {
  description = "Web Load Balancer Public Address"
  value = module.scaleset.web_lb_public_ip_address
}

# Load Balancer ID
output "web_lb_id" {
  description = "Web Load Balancer ID."
  value = module.scaleset.web_lb_id
}

# Load Balancer Frontend IP Configuration Block
output "web_lb_frontend_ip_configuration" {
  description = "Web LB frontend_ip_configuration Block"
  value = module.scaleset.web_lb_frontend_ip_configuration
}

# The Hostname of the Redis Instance
output "redis_host" {
  description = "The private IP address of the Redis Instance."
  value = module.scaleset.redis_host
}