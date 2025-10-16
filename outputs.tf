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
