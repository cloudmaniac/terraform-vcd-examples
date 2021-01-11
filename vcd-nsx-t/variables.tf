## Cloud Director Provider
variable "vcd_user" {}
variable "vcd_pass" {}
variable "vcd_url" {}

variable "vcd_allow_unverified_ssl" {
  default = true
}

variable "vcd_max_retry_timeout" {
  default = 60
}

## Infra
variable "pvdc_name" {}
variable "network_pool_name" {}
variable "external_network_t_pod02_internet" {}

## Organization
variable "org_name" {}
variable "ovdc01_name" {}
variable "edge01_name" {}

##################################################################
##### OLDIES
##################################################################

#variable "external_network_v_pod02_internet" {}
#variable "external_network_v_pod02_service" {}

#variable "t1_edge01_internet_ip" {} # IP address of edge gateway uplink interface on the "internet" external network
#variable "t1_edge02_internet_ip" {} # IP address of edge gateway uplink interface on the "internet" external network
#variable "vapp_xyz_web_dnat_ip_prefix" {}