# Example: `consul-cluster`

This is an example of the `terraform-hcp-hvn-azure` module, showcasing how to deploy an [HCP Consul Cluster](https://cloud.hashicorp.com/products/consul).

<!-- BEGIN_TF_DOCS -->
### Inputs

No inputs.

### Outputs

| Name | Description |
|------|-------------|
| azuread_service_principal | Exported Attributes for `azuread_service_principal`. |
| azurerm_role_assignment | Exported Attributes for `azurerm_role_assignment`. |
| azurerm_role_definition | Exported Attributes for `azurerm_role_definition`. |
| hcp_azure_peering_connection | Exported Attributes for `hcp_azure_peering_connection`. |
| hcp_consul_cluster | Exported Attributes for `hcp_consul_cluster`. |
| hcp_hvn | Exported Attributes for `hcp_hvn`. |
| hcp_hvn_route | Exported Attributes for `hcp_hvn_route`. |
| portal_hvn_overview_url | HashiCorp Cloud Platform HVN Overview URL. |
| portal_hvn_peering_url | HashiCorp Cloud Platform HVN Peering URL. |
| portal_hvn_route_table_url | HashiCorp Cloud Platform HVN Route Table URL. |
<!-- END_TF_DOCS -->
