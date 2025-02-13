# Cycloid
variable "cycomp" {}
variable "cyenv" {}
variable "cyproject" {}
variable "cyorg" {}

variable "rds_engine_version" {
  description = "The engine version to use."
  default = "8.0"
}

variable "rds_instance_class" {
  description = "The instance type of the RDS instance."
  default = "db.t4g.micro"
}

variable "rds_snapshot_identifier" {
  description = "Create this database from a snapshot. This corresponds to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
}

variable "rds_subnet_id" {
  description = "Subnets where to deploy the RDS instance."
}

variable "app_security_group_id" {
  description = "The application security group to grant access to the database."
}

variable "vm_disk_size" {
  description = "Disk size for the instances (Go)"
  default = "20"
}

variable "vm_os_user" {
  description = "Admin username to connect to instances via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

