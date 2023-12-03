module "network" {
  #####################################
  # Do not modify the following lines #
  source   = "git::https://github.com/cycloid-community-catalog/onboarding-iac.git//aws/network"
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

  #. vpc_cidr: "10.0.0.0/16"
  #+ Public Subnet CIDR
  vpc_cidr = "Value injected by StackForms"

  #. vpc_public_subnet: "10.0.0.0/24"
  #+ Public Subnet CIDR
  vpc_public_subnet = "Value injected by StackForms"

  #. vpc_private_subnet: "10.0.1.0/24"
  #+ Private Subnet CIDR
  vpc_private_subnet = "Value injected by StackForms"

}

module "keypair" {
  #####################################
  # Do not modify the following lines #
  source   = "git::https://github.com/cycloid-community-catalog/onboarding-iac.git//aws/keypair"
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
  #+ The name of the key pair to provision to the instance
  key_pair_name = "${var.customer}-${var.project}-${var.env}"

  #. key_pair_public: ""
  #+ Public key to create
  key_pair_public = var.keypair_public

}

module "bastion" {
  #####################################
  # Do not modify the following lines #
  source   = "git::https://github.com/cycloid-community-catalog/onboarding-iac.git//aws/ec2"
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

  #. vm_instance_type: "t2.micro"
  #+ Instance type to deploy
  vm_instance_type = "t2.micro"

  #. vm_disk_size: 20
  #+ Disk size for the instance (Go)
  vm_disk_size = 20

  #. associate_public_ip_address: true
  #+ Whether to associate a public IP on the primary interface or not
  associate_public_ip_address = true

  #. key_pair_name: ""
  #+ The name of the key pair to provision to the instance
  key_pair_name = module.keypair.key_pair.key_name

  #. subnet_id: ''
  #+ Subnet ID where to deploy the EC2 instance
  subnet_id = module.network.public_subnet_id

}
