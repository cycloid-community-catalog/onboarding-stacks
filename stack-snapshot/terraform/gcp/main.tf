module "snapshot" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-snapshot"
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

  #. vm_machine_type: 'n2-standard-2'
  #+ Machine type for the Snapshot
  vm_machine_type = "Value injected by StackForms"

  #. vm_disk_size: 20
  #+ Disk size for the Snapshot (Go)
  vm_disk_size = "Value injected by StackForms"

  #. subnet_self_link: ""
  #+ The GCP subnet self link where to deploy the instances
  subnet_self_link = "Value injected by StackForms"
}