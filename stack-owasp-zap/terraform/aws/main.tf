module "zap" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-zap"
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

  #. key_pair_name: ""
  #+ The public SSH key, for SSH access to newly-created instances
  key_pair_name = "Value injected by StackForms"

  #
  # OWASP Zed Attack Proxy (ZAP)
  #

  #. vm_instance_type: 't3.micro'
  #+ Instance type for the OWASP Zed Attack Proxy (ZAP)
  vm_instance_type = "Value injected by StackForms"

  #. vm_disk_size: 20
  #+ Disk size for the OWASP Zed Attack Proxy (ZAP) (Go)
  vm_disk_size = "Value injected by StackForms"

  #. zap_port: 8081
  #+ Port where OWASP Zed Attack Proxy (ZAP) service is exposed
  zap_port = "Value injected by StackForms"

  #. vpc_id: ''
  #+ VPC ID where to deploy the EC2 instance
  vpc_id = "Value injected by StackForms"

  #. key_pair_name: ''
  #+ Public Key pair name to provision to the EC2 instance
  key_pair_name = "Value injected by StackForms"
}