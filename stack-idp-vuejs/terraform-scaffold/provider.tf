provider "cycloid" {
  url                    = var.cycloid_api_url
  jwt                    = var.cyorg_jwt
  organization_canonical = var.cyorg
}

provider "github" {
  token = var.github_pat
}
