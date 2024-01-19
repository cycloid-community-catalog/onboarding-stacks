# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

#
# vSphere
#
variable "vsphere_datacenter" {
  description = "Datacenter where to create the virtual machine"
  default     = "dc1"
}

variable "vsphere_datastore" {
  description = "Datastore where to create the virtual machine"
  default     = "datastore1"
}

variable "vsphere_cluster" {
  description = "Cluster where to create the virtual machine"
  default     = "cluster1"
}

variable "vsphere_template" {
  description = "Virtual machine template"
  default     = "debian"
}

variable "vsphere_network" {
  description = "Network to connect the virtual machine to"
  default     = "VM Network"
}

#
# Nexus Repository
#
variable "vm_ip" {
  description = "IP address of the virtual machine"
  default     = "212.129.18.92"
}

variable "vm_mac" {
  description = "MAC address of the virtual machine"
  default     = "00:50:56:01:f1:96"
}

variable "vm_cpu" {
  description = "Number of CPU for the Nexus Repository"
  default     = "2"
}

variable "vm_memory" {
  description = "Memory allocated for the Nexus Repository"
  default     = "8192"
}

variable "vm_disk_size" {
  description = "Disk size for the Nexus Repository (Go)"
  default = "20"
}