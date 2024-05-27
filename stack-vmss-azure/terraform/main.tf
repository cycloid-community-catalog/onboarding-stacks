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

  #. subnet_id: ''
  #+ The Subnet ID where to deploy the resources
  subnet_id = "Value injected by StackForms"

  #. vmss_instance_type: "Standard_DS2_v2"
  #+ The Virtual Machine SKU for the Scale Set, such as Standard_DS2_v2
  vmss_instance_type = "Value injected by StackForms"

  #. vmss_instances: 1
  #+ The number of Virtual Machines in the Scale Set.
  vmss_instances = "Value injected by StackForms"
}

module "cycloid" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-cycloid"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. vm_os_user: ''
  #+ Admin username to connect to instances
  vm_os_user = module.scaleset.vm_os_user

  #. vmss_instance_type: "Standard_DS2_v2"
  #+ User password to connect to instances
  vm_password = module.scaleset.vm_password

}