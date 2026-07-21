# HashiCorp Cloud Platform: HVN for Azure

This Terraform Module provisions a HashiCorp Virtual Network for use with Microsoft Azure.

## Table of Contents

<!-- TOC -->
* [HashiCorp Cloud Platform: HVN for Azure](#hashicorp-cloud-platform--hvn-for-azure)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Standalone HVN (no peering)](#standalone-hvn-no-peering)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

* HashiCorp Cloud Platform (HCP) [Account](https://portal.cloud.hashicorp.com/sign-in)
* Azure [Account](https://azure.microsoft.com/)
* Terraform `1.2.x` or newer.

> **Warning**
> Ensure that the Azure account that Terraform uses has the required API permissions to manage the full lifecycle of AD Service Principal creation.
> An AD Service Principal with insufficient rights (e.g.: `Application.ReadWrite.All`) may result in HVN creation not completing successfully.

## Usage

For examples, see the [./examples](https://github.com/ksatirli/terraform-hcp-hvn-azure/tree/main/examples/) directory.

### Standalone HVN (no peering)

By default, this module creates an Azure VNet peering connection alongside the HVN, along with the Service Principal, Role Definition, and Role Assignment it requires. Set `create_peering = false` to provision a standalone HVN with no Azure connectivity — for example, when the HVN backs a cluster reached over a public endpoint, or when peering it into an unrelated VNet would create an unwanted coupling.

When `create_peering = false`:

* `resource_group_name`, `routing_table_cidrs`, `subscription_id`, `tenant_id`, and `vnet_name` are ignored.
* The `hcp_azure_peering_connection`, `azuread_service_principal`, `azurerm_role_definition`, and `azurerm_role_assignment` outputs are `null`, and `hcp_hvn_route` is an empty map.
* Consumers must still configure the `azurerm` and `azuread` providers. Terraform initializes every provider declared in a module's `required_providers`, and `azurerm` 4.x errors without a `subscription_id`. See [`examples/hvn-only`](https://github.com/ksatirli/terraform-hcp-hvn-azure/tree/main/examples/hvn-only) for a minimal working configuration.

Setting `create_peering = true` (the default) without one of `resource_group_name`, `subscription_id`, `tenant_id`, or `vnet_name` fails at plan time with a precondition error listing every missing input.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr_block | The CIDR range of the HVN. | `string` | n/a | yes |
| identifier | The ID of the HashiCorp Virtual Network (HVN). | `string` | n/a | yes |
| region | Azure Region to deploy HVN in. | `string` | n/a | yes |
| allow_forwarded_traffic | Whether to allow forwarded traffic from the HVN to the peer VNet. | `bool` | `false` | no |
| create_peering | Whether to create an Azure VNet peering connection, its Service Principal, Role Definition, Role Assignment, and HVN routes. Set to `false` to provision a standalone HVN with no Azure connectivity (for example, when the HVN backs a cluster reached over a public endpoint). When `false`, `resource_group_name`, `routing_table_cidrs`, `subscription_id`, `tenant_id`, and `vnet_name` are ignored. | `bool` | `true` | no |
| resource_group_name | The resource group name of the peer VNet in Azure. Required when `create_peering` is `true`. | `string` | `null` | no |
| routing_table_cidrs | List of Objects containing Name and CIDR for (multiple) HVN Routing Tables. Ignored when `create_peering` is `false`. | <pre>list(object({<br>    name = string<br>    cidr = string<br>  }))</pre> | `[]` | no |
| subscription_id | The subscription ID of the peer VNet in Azure. Required when `create_peering` is `true`. | `string` | `null` | no |
| tenant_id | The tenant ID of the peer VNet in Azure. Required when `create_peering` is `true`. | `string` | `null` | no |
| use_remote_gateways | Whether to use remote gateways for the peering connection. | `bool` | `false` | no |
| vnet_name | The name of the peer VNet in Azure. Required when `create_peering` is `true`. | `string` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| azuread_service_principal | Azure AD Service Principal for the HVN peering. `null` when `create_peering` is `false`. |
| azurerm_role_assignment | Azure Role Assignment for the HVN Service Principal. `null` when `create_peering` is `false`. |
| azurerm_role_definition | Azure Role Definition for the HVN Service Principal. `null` when `create_peering` is `false`. |
| hcp_azure_peering_connection | HCP Azure Peering Connection. `null` when `create_peering` is `false`. |
| hcp_hvn | Exported Attributes for `hcp_hvn`. |
| hcp_hvn_route | Exported Attributes for `hcp_hvn_route`. |
| portal_hvn_overview_url | HashiCorp Cloud Platform HVN Overview URL. |
| portal_hvn_peering_url | HashiCorp Cloud Platform HVN Peering URL. `null` when `create_peering` is `false`. |
| portal_hvn_route_table_url | HashiCorp Cloud Platform HVN Route Table URL. |
<!-- END_TF_DOCS -->

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/terraform-hcp-hvn-azure/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
