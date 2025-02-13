provider "aws" {
  access_key = var.aws_cred.access_key
  secret_key = var.aws_cred.secret_key
  region     = var.aws_region

  default_tags { # The default_tags block applies tags to all resources managed by this provider, except for the Auto Scaling groups (ASG).
    tags = {
      "cycloid.io" = "true"
      cyenv          = var.cyenv
      cyproject      = var.cyproject
      cyorg = var.cyorg
      demo         = true
      monitoring_discovery = false
    }
  }
}

provider "cycloid" {
  organization_canonical = var.cyorg
  jwt                    = var.cyorg_jwt
  url                    = var.cycloid_api_url
}