## Terraform Initialization
terraform {
  required_version = ">= 0.13"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.1.0"
    }
  }
}

# Configure VMware vCloud Director Provider
provider "vcd" {
  user                 = var.vcd_user
  password             = var.vcd_pass
  org                  = "System"
  url                  = var.vcd_url
  max_retry_timeout    = var.vcd_max_retry_timeout
  allow_unverified_ssl = var.vcd_allow_unverified_ssl
}

## Organization VDC
data "vcd_org_vdc" "source_ovdc_config" {
  name = var.ovdc_name
  org  = var.org_name
}

## Edge Gateways
data "vcd_resource_list" "list_of_nsxv_edges" {
  name = "list_of_nsxv_edges"
  org  = var.org_name
  vdc  = var.ovdc_name

  resource_type = "vcd_edgegateway"
  list_mode     = "name"
}

// Uses the list of edge gateways to get the data source of each
data "vcd_edgegateway" "full_nsxv_edges" {
  count = length(data.vcd_resource_list.list_of_nsxv_edges.list)
  name  = data.vcd_resource_list.list_of_nsxv_edges.list[count.index]
  org   = var.org_name
  vdc   = var.ovdc_name
}