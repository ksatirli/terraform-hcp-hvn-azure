# HashiCorp Cloud Platform: HVN for Azure

This Terraform Module provisions a HashiCorp Virtual Network for use with Microsoft Azure.

## Table of Contents

<!-- TOC -->
* [HashiCorp Cloud Platform: HVN for Azure](#hashicorp-cloud-platform--hvn-for-azure)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
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

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr_block | The CIDR range of the HVN. | `string` | n/a | yes |
| identifier | The ID of the HashiCorp Virtual Network (HVN). | `string` | n/a | yes |
| region | Azure Region to deploy HVN in. | `string` | n/a | yes |
| resource_group_name | The resource group name of the peer VNet in Azure. | `string` | n/a | yes |
| routing_table_cidrs | List of Objects containing Name and CIDR for (multiple) HVN Routing Tables. | <pre>list(object({<br/>    name = string<br/>    cidr = string<br/>  }))</pre> | n/a | yes |
| subscription_id | The subscription ID of the peer VNet in Azure. | `string` | n/a | yes |
| tenant_id | The tenant ID of the peer VNet in Azure. | `string` | n/a | yes |
| vnet_name | The name of the peer VNet in Azure. | `string` | n/a | yes |
| allow_forwarded_traffic | Whether to allow forwarded traffic from the HVN to the peer VNet. | `bool` | `false` | no |
| use_remote_gateways | Whether to use remote gateways for the peering connection. | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| azuread_service_principal | Exported Attributes for `azuread_service_principal`. |
| azurerm_role_assignment | Exported Attributes for `azurerm_role_assignment`. |
| azurerm_role_definition | Exported Attributes for `azurerm_role_definition`. |
| hcp_azure_peering_connection | Exported Attributes for `hcp_azure_peering_connection`. |
| hcp_hvn | Exported Attributes for `hcp_hvn`. |
| hcp_hvn_route | Exported Attributes for `hcp_hvn_route`. |
<!-- END_TF_DOCS -->

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/terraform-hcp-hvn-azure/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
