variable "subscription_id" {
  description = "Azure Subscription ID. Only used to satisfy the azurerm provider, which is initialized but unused when create_peering is false."
  type        = string
}

module "hvn" {
  source = "../../"

  cidr_block     = "172.25.16.0/20"
  create_peering = false
  identifier     = "example-hvn-only"
  region         = "francecentral"
}

output "hvn_id" {
  description = "The HVN's ID."
  value       = module.hvn.hcp_hvn.hvn_id
}
