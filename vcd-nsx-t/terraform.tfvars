## Cloud Director Provider
vcd_user                 = "administrator"
vcd_pass                 = "VMware1!"
vcd_url                  = "https://cloud.emea.cluster.net/api"
vcd_max_retry_timeout    = "60"
vcd_allow_unverified_ssl = "true"

## Infra
network_pool_name                 = "np-pod02-geneve"
pvdc_name                         = "pvdc-pod02-t"
external_network_t_pod02_internet = "ext-t-pod02-shared"

## Organization
org_name    = "rainpole"
ovdc01_name = "rainpole-ovdc01"
edge01_name = "rainpole-edge01"