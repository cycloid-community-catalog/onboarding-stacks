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

  #. key_pair_public: ""
  #+ The public SSH key, for SSH access to newly-created instances
  key_pair_public = var.key_pair_public

  #. subnet_self_link: ""
  #+ The GCP subnet self link where to deploy the instances
  subnet_self_link = "Value injected by StackForms"


  #
  # OWASP Zed Attack Proxy (ZAP)
  #

  #. vm_machine_type: 'n2-standard-2'
  #+ Machine type for the OWASP Zed Attack Proxy (ZAP)
  vm_machine_type = "Value injected by StackForms"

  #. vm_disk_size: 20
  #+ Disk size for the OWASP Zed Attack Proxy (ZAP) (Go)
  vm_disk_size = "Value injected by StackForms"

  #. zap_port: 8080
  #+ Port where OWASP Zed Attack Proxy (ZAP) service is exposed
  zap_port = "Value injected by StackForms"
}