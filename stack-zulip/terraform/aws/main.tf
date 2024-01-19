module "zulip" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-zulip"
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

  #
  # Zulip
  #

  #. zulip_email: ''
  #+ Admin email address
  zulip_email = "Value injected by StackForms"

  #. zulip_domain: ''
  #+ Domain name for the Zulip server and portal
  # zulip_domain = "Value injected by StackForms"

  #. zulip_subdomain: ''
  #+ Sub-domain name to create for the Zulip server and portal
  # zulip_subdomain = "Value injected by StackForms"

  #. zulip_port: 8080
  #+ Port where Zulip service is exposed
  zulip_port = "Value injected by StackForms"

  #. vm_instance_type: 't3.micro'
  #+ Instance type for the Zulip server
  vm_instance_type = "Value injected by StackForms"

  #. vm_disk_size: 20
  #+ Disk size for the Zulip server (Go)
  vm_disk_size = "Value injected by StackForms"

  #. vpc_id: ''
  #+ VPC ID where to deploy the EC2 instance
  vpc_id = "Value injected by StackForms"

  #. key_pair_name: ''
  #+ Public Key pair name to provision to the EC2 instance
  key_pair_name = "Value injected by StackForms"

  #. cycloid_api_key: ""
  #+ The Cycloid API key to send custom events
  # cycloid_api_key = var.cycloid_api_key

}