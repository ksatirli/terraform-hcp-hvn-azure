# Example: `basic`

This is a _basic_ example of the `terraform-hcp-hvn-azure` module.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | The Cloud Environment which should be used. | `string` | `"public"` | no |
| location | The Azure region in which to operate | `string` | `"westus2"` | no |
| routing_table_cidrs | List of Objects containing Name and CIDR for (multiple) HVN Routing Tables. | <pre>list(object({<br>    name = string<br>    cidr = string<br>  }))</pre> | <pre>[<br>  {<br>    "cidr": "172.16.0.0/16",<br>    "name": "Management"<br>  },<br>  {<br>    "cidr": "172.26.0.0/16",<br>    "name": "Platform"<br>  }<br>]</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| azuread_service_principal | Exported Attributes for `azuread_service_principal`. |
| azurerm_role_assignment | Exported Attributes for `azurerm_role_assignment`. |
| azurerm_role_definition | Exported Attributes for `azurerm_role_definition`. |
| hcp_azure_peering_connection | Exported Attributes for `hcp_azure_peering_connection`. |
| hcp_hvn | Exported Attributes for `hcp_hvn`. |
| hcp_hvn_route | Exported Attributes for `hcp_hvn_route`. |
| portal_hvn_overview_url | HashiCorp Cloud Platform HVN Overview URL. |
| portal_hvn_peering_url | HashiCorp Cloud Platform HVN Peering URL. |
| portal_hvn_route_table_url | HashiCorp Cloud Platform HVN Route Table URL. |
<!-- END_TF_DOCS -->
