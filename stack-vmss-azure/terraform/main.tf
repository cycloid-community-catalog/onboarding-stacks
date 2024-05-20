module "scaleset" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-scaleset"
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

  #. resource_group_name: ''
  #+ The name of the resource group to create
  resource_group_name = "Value injected by StackForms"

  #. vmss_instance_type: "Standard_DS2_v2"
  #+ The Virtual Machine SKU for the Scale Set, such as Standard_DS2_v2
  vmss_instance_type = "Value injected by StackForms"

  #. vmss_instances: 1
  #+ The number of Virtual Machines in the Scale Set.
  vmss_instances = "Value injected by StackForms"
}