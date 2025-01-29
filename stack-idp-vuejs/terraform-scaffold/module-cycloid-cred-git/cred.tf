# resource "cycloid_credential" "git" {
#   name                   = var.cyproject
#   description            = "URL, branch and SSH private key allowing access to a code git repository."
#   organization_canonical = var.cyorg
#   path                   = var.cyproject
#   canonical              = var.cyproject

#   type = "custom"
#   body = {
#     git_ssh_url = var.git_ssh_url
#     git_branch_prod = var.git_branch_prod
#     git_branch_staging = var.git_branch_staging
#     git_ssh_key = chomp(var.git_ssh_key)
#   }
# }

resource "cycloid_credential" "git-ssh" {
  name                   = "${var.cyproject}"
  description            = "SSH private key allowing access to a code git repository."
  organization_canonical = var.cyorg
  path                   = "${var.cyproject}"
  canonical              = "${var.cyproject}"

  type = "ssh"
  body = {
    ssh_key = chomp(var.git_ssh_key)
  }
}