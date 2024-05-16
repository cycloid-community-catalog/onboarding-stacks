module "aks" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-aks"
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

  #. kubernetes_version: '1.30'
  #+ Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region.
  kubernetes_version = "Value injected by StackForms"

  #. kubernetes_sku_tier: 'Free'
  #+ The SKU Tier that should be used for this Kubernetes Cluster.
  kubernetes_sku_tier = "Value injected by StackForms"

  #. resource_group_name: ''
  #+ The name of the existing resource group where the resources will be deployed
  resource_group_name = "Value injected by StackForms"
}
