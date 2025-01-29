resource "github_repository" "scaffold" {
  name        = "${var.cyorg}-${var.cyproject}"
  description = "Repo for ${var.cyproject} project"

  visibility = "private"
  auto_init  = true
}

resource "github_branch" "staging" {
  repository = github_repository.scaffold.name
  branch     = "staging"
}

resource "github_branch_default" "staging"{
  repository = github_repository.scaffold.name
  branch     = github_branch.staging.branch
}

resource "tls_private_key" "github_generated_key" {
  algorithm   = "ED25519"
}

resource "github_repository_deploy_key" "scaffold" {
  title      = "${var.cyproject}"
  repository = github_repository.scaffold.name
  key        = tls_private_key.github_generated_key.public_key_openssh
  read_only  = false
}