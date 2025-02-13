module "rds" {
  #####################################
  # Do not modify the following lines #
  source    = "./module-rds"
  cycomp    = var.cycomp
  cyenv     = var.cyenv
  cyproject = var.cyproject
  cyorg     = var.cyorg
  #####################################

  #. rds_engine_version: '8.0'
  #+ The MySQL engine version to use.
  rds_engine_version = "8.0"

  #. rds_instance_class: 'db.t4g.micro'
  #+ The instance type of the RDS instance.
  rds_instance_class = "db.t4g.micro"

  #. rds_snapshot_identifier: ''
  #+ Create this database from a snapshot. This corresponds to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05.
  rds_snapshot_identifier = "Value injected by StackForms"

  #. rds_subnet_id: ''
  #+ Subnets where to deploy the resources
  rds_subnet_id = "Value injected by StackForms"

  #. app_security_group_id: ''
  #+ The application security group to grant access to the database
  app_security_group_id = "Value injected by StackForms"

}