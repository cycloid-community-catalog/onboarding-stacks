module "function" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-function"
  cyproject  = var.cyproject
  cyenv      = var.cyenv
  cyorg = var.cyorg
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    demo = true
    monitoring_discovery = false
  }

  #. subscription_id: ''
  #+ The subscription ID that will be queried. This is to create the correct role to the function attached identity.
  subscription_id = var.azure_cred["subscription_id"]

  #. resource_group_name: ''
  #+ The name of the existing resource group where the resources will be deployed
  resource_group_name = "Value injected by StackForms"

  #. azure_location: "West Europe"
  #+ Azure location
  azure_location = "Value injected by StackForms"

  #. python_version: "3.11"
  #+ Python version
  python_version = "Value injected by StackForms"

  #. service_plan_sku_name: "Y1"
  #+ Service plan SKU name
  service_plan_sku_name = "Value injected by StackForms"

}