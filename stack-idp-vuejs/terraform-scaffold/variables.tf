# Cycloid variables
variable "cyenv" {}
variable "cyproject" {}
variable "cyorg" {}

variable "cycloid_api_url" {
  type        = string
  default     = "https://api.us.cycloid.io/"
  description = "Cycloid API endpoint"
}

variable "cyorg_jwt" {
  type        = string
  description = "Cycloid Organization JWT used for authentication"
  sensitive   = true
}

variable "github_pat" {
  type        = string
  description = "GitHub Personal Access Token"
  sensitive   = true
}