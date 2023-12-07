module "resource-group" {
  #####################################
  # Do not modify the following lines #
  source   = "git::https://github.com/cycloid-community-catalog/onboarding-iac.git//azure/resource-group"
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

  #. name: ''
  #+ The name of the resource group to create
  name = "Value injected by StackForms"

  #. azure_location: "West Europe"
  #+ Azure location where to create the Resource Group
  azure_location = "Value injected by StackForms"
}

module "network" {
  #####################################
  # Do not modify the following lines #
  source   = "git::https://github.com/cycloid-community-catalog/onboarding-iac.git//azure/network"
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
  #+ The name of the existing resource group where the resources will be deployed
  resource_group_name = module.resource-group.name

  #. azure_location: "West Europe"
  #+ Azure location where to create Networking resources
  azure_location = module.resource-group.location

  #. network_cidr: "10.0.0.0/16"
  #+ The CIDR of the Virtual Network
  network_cidr = "Value injected by StackForms"

  #. private_subnet_cidr: "10.0.0.0/24"
  #+ The private CIDR for the Subnet
  private_subnet_cidr = "Value injected by StackForms"

  #. public_subnet_cidr: "10.0.1.0/24"
  #+ The public CIDR for the Subnet
  public_subnet_cidr = "Value injected by StackForms"
}