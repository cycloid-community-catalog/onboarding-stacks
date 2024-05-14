module "nodepool" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-nodepool"
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

  #. kubernetes_cluster_id: ''
  #+ The existing Azure Kubernetes cluster (AKS) where the nodepool will be deployed.
  kubernetes_cluster_id = "Value injected by StackForms"

  #. nodepool_vm_size: ''
  #+ The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created
  nodepool_vm_size = "Value injected by StackForms"

  #. nodepool_node_count: ''
  #+ The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 (inclusive) for user pools and between 1 and 1000 (inclusive) for system pools and must be a value in the range min_count - max_count
  nodepool_node_count = "Value injected by StackForms"

}
