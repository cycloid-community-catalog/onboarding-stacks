# Cycloid variables
variable "cyenv" {}
variable "cyproject" {}
variable "cyorg" {}

# variable "git_ssh_url" {
#   description = "URL of a code git repository."
# }

# variable "git_branch_prod" {
#   description = "Branch of a code git repository for the prod platform."
# }

# variable "git_branch_staging" {
#   description = "Branch of a code git repository for the staging platform."
# }

variable "git_ssh_key" {
  description = "SSH private key allowing access to a code git repository."
  sensitive = true
}