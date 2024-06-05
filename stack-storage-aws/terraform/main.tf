module "storage" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-storage"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    demo = true
    monitoring_discovery = false
  }

  #. s3_bucket_name: ''
  #+ The name of the bucket. If omitted, Terraform will assign a random, unique name.
  s3_bucket_name = "foobar"  # This value will be overridden by StackForms (cf. .forms.yml)

  #. cycloid_root_org_canonical: ''
  #+ Canonical of the root Cycloid Organization where to create the child organization
  s3_force_destroy = false  # This value will be overridden by StackForms (cf. .forms.yml)

}