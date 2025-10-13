output "hcp_hvn" {
  description = "Exported Attributes for `hcp_hvn`."
  value       = hcp_hvn.main
}

output "hcp_azure_peering_connection" {
  description = "Exported Attributes for `hcp_azure_peering_connection`."
  value       = hcp_azure_peering_connection.main
}

output "azuread_service_principal" {
  description = "Exported Attributes for `azuread_service_principal`."
  value       = azuread_service_principal.main
}

output "azurerm_role_definition" {
  description = "Exported Attributes for `azurerm_role_definition`."
  value       = azurerm_role_definition.main
}

output "azurerm_role_assignment" {
  description = "Exported Attributes for `azurerm_role_assignment`."
  value       = azurerm_role_assignment.role_assignment
}

output "hcp_hvn_route" {
  description = "Exported Attributes for `hcp_hvn_route`."
  value       = hcp_hvn_route.main
}

locals {
  org_id   = hcp_hvn.main.organization_id
  hvn_url  = "${var.hcp_base_url}/orgs/${local.org_id}/projects/${hcp_hvn.main.project_id}/hvns/${hcp_hvn.main.hvn_id}"
}

output "portal_hvn_overview_url" {
  description = "HashiCorp Cloud Platform HVN Overview URL."
  value       = local.hvn_url
}

output "portal_hvn_peering_url" {
  description = "HashiCorp Cloud Platform HVN Peering URL."
  value       = "${local.hvn_url}/peerings/${hcp_azure_peering_connection.main.peering_id}?product=consul&tab=terminal"
}

output "portal_hvn_route_table_url" {
  description = "HashiCorp Cloud Platform HVN Route Table URL."
  value       = "${local.hvn_url}/route-table"
}
