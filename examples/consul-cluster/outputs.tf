output "hcp_consul_cluster" {
  description = "Exported Attributes for `hcp_consul_cluster`."
  value       = hcp_consul_cluster.main
  sensitive   = true
}

#
# The following outputs have been (previously) defined in `./examples/basic/outputs.tf`.
# The `value` references have been adjusted for this module but are otherwise identical.
#
output "hcp_hvn" {
  description = "Exported Attributes for `hcp_hvn`."
  value       = module.basic.hcp_hvn
}

output "hcp_azure_peering_connection" {
  description = "Exported Attributes for `hcp_azure_peering_connection`."
  value       = module.basic.hcp_azure_peering_connection
}

output "azuread_service_principal" {
  description = "Exported Attributes for `azuread_service_principal`."
  value       = module.basic.azuread_service_principal
}

output "azurerm_role_definition" {
  description = "Exported Attributes for `azurerm_role_definition`."
  value       = module.basic.azurerm_role_definition
}

output "azurerm_role_assignment" {
  description = "Exported Attributes for `azurerm_role_assignment`."
  value       = module.basic.azurerm_role_assignment
}

output "hcp_hvn_route" {
  description = "Exported Attributes for `hcp_hvn_route`."
  value       = module.basic.hcp_hvn_route
}

output "portal_hvn_overview_url" {
  description = "HashiCorp Cloud Platform HVN Overview URL."
  value       = module.basic.portal_hvn_overview_url
}

output "portal_hvn_peering_url" {
  description = "HashiCorp Cloud Platform HVN Peering URL."
  value       = module.basic.portal_hvn_peering_url
}

output "portal_hvn_route_table_url" {
  description = "HashiCorp Cloud Platform HVN Route Table URL."
  value       = module.basic.portal_hvn_route_table_url
}
