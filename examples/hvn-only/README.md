<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subscription_id | Azure Subscription ID. Only used to satisfy the azurerm provider, which is initialized but unused when create_peering is false. | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| hvn_id | The HVN's ID. |
<!-- END_TF_DOCS -->