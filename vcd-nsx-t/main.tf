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

# Data sources
data "vcd_external_network_v2" "internet" {
  name = var.external_network_t_pod02_internet
}

# Create a new org
resource "vcd_org" "org_01" {
  name             = var.org_name
  full_name        = "Rainpole"
  description      = "Rainpole Organization"
  is_enabled       = "true"
  delete_recursive = "true"
  delete_force     = "true"
}

# Create organization VDC for above org
resource "vcd_org_vdc" "ovdc01" {
  depends_on = [vcd_org.org_01]

  name              = var.ovdc01_name
  description       = "NSX-T Organization VDC, provisioned with Terraform"
  org               = var.org_name
  allocation_model  = "AllocationVApp"
  network_pool_name = var.network_pool_name
  provider_vdc_name = var.pvdc_name

  compute_capacity {
    cpu {
      limit = 0
    }
    memory {
      limit = 0
    }
  }

  storage_profile {
    name    = "vSAN Default Storage Policy"
    limit   = 204800
    default = true
  }

  vm_quota                 = 100
  network_quota            = 100
  enabled                  = true
  enable_thin_provisioning = true
  enable_fast_provisioning = true
  delete_force             = true
  delete_recursive         = true
}

# Create edge gateway
resource "vcd_nsxt_edgegateway" "nsxt-edge" {
  depends_on = [vcd_org_vdc.ovdc01]

  org         = var.org_name
  vdc         = var.ovdc01_name
  name        = var.edge01_name
  description = "Rainpole edge gateway"

  external_network_id = data.vcd_external_network_v2.internet.id

  subnet {
    gateway       = "10.67.29.254"
    prefix_length = "24"

    allocated_ips {
      start_address = "10.67.29.171"
      end_address   = "10.67.29.179"
    }
  }
}