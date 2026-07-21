output "hcp_hvn" {
  description = "Exported Attributes for `hcp_hvn`."
  value       = hcp_hvn.main
}

output "hcp_azure_peering_connection" {
  description = "HCP Azure Peering Connection. `null` when `create_peering` is `false`."
  value       = var.create_peering ? hcp_azure_peering_connection.main[0] : null
}

output "azuread_service_principal" {
  description = "Azure AD Service Principal for the HVN peering. `null` when `create_peering` is `false`."
  value       = var.create_peering ? azuread_service_principal.main[0] : null
}

output "azurerm_role_definition" {
  description = "Azure Role Definition for the HVN Service Principal. `null` when `create_peering` is `false`."
  value       = var.create_peering ? azurerm_role_definition.main[0] : null
}

output "azurerm_role_assignment" {
  description = "Azure Role Assignment for the HVN Service Principal. `null` when `create_peering` is `false`."
  value       = var.create_peering ? azurerm_role_assignment.role_assignment[0] : null
}

output "hcp_hvn_route" {
  description = "Exported Attributes for `hcp_hvn_route`."
  value       = hcp_hvn_route.main
}

locals {
  base_url = "https://portal.cloud.hashicorp.com"
  org_id   = hcp_hvn.main.organization_id
  hvn_url  = "${local.base_url}/orgs/${local.org_id}/projects/${hcp_hvn.main.project_id}/hvns/${hcp_hvn.main.hvn_id}"
}

output "portal_hvn_overview_url" {
  description = "HashiCorp Cloud Platform HVN Overview URL."
  value       = local.hvn_url
}

output "portal_hvn_peering_url" {
  description = "HashiCorp Cloud Platform HVN Peering URL. `null` when `create_peering` is `false`."
  value       = var.create_peering ? "${local.hvn_url}/peerings/${hcp_azure_peering_connection.main[0].peering_id}?product=consul&tab=terminal" : null
}

output "portal_hvn_route_table_url" {
  description = "HashiCorp Cloud Platform HVN Route Table URL."
  value       = "${local.hvn_url}/route-table"
}
