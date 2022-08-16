# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn
resource "hcp_hvn" "main" {
  hvn_id         = var.identifier
  cloud_provider = "azure"
  region         = var.region
  cidr_block     = var.cidr_block
}

# establish a peering connection between the VPC and HVN
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/azure_peering_connection
resource "hcp_azure_peering_connection" "main" {
  hvn_link                 = hcp_hvn.main.self_link
  peering_id               = var.identifier
  peer_resource_group_name = var.resource_group_name
  peer_subscription_id     = var.subscription_id
  peer_tenant_id           = var.tenant_id
  peer_vnet_name           = var.vnet_name
  peer_vnet_region         = var.region
}

locals {
  # convenient local to assemble Virtual Network Identifier from known and dynamic parts
  vnet_identifier = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.vnet_name}"
}

# create Active Directory Service Principal for HVN
# see https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal
resource "azuread_service_principal" "main" {
  application_id = hcp_azure_peering_connection.main.application_id
}

# manage role definition for Service Principal
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition
resource "azurerm_role_definition" "main" {
  name        = "${var.identifier}-${hcp_azure_peering_connection.main.application_id}"
  description = "Terraform-managed Role Definition for HCP HVN Service Principal."
  scope       = local.vnet_identifier

  assignable_scopes = [
    local.vnet_identifier
  ]

  permissions {
    actions = [
      "Microsoft.Network/virtualNetworks/peer/action",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/read",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write"
    ]
  }
}

# assign role definition to Service Principal
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "role_assignment" {
  principal_id       = azuread_service_principal.main.id
  role_definition_id = azurerm_role_definition.main.role_definition_resource_id
  scope              = local.vnet_identifier
}

# wait for previous resource (`hcp_azure_peering_connection`) to become active, before continuing operations using data source
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/azure_peering_connection
data "hcp_azure_peering_connection" "main" {
  hvn_link              = hcp_hvn.main.self_link
  peering_id            = hcp_azure_peering_connection.main.peering_id
  wait_for_active_state = true
}

# create route for HVN
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn_route
resource "hcp_hvn_route" "main" {
  for_each = {
    for cidr in var.routing_table_cidrs :
    cidr.name => cidr
  }

  hvn_link         = hcp_hvn.main.self_link
  hvn_route_id     = "${var.identifier}-${each.key}"
  destination_cidr = each.value.cidr
  target_link      = data.hcp_azure_peering_connection.main.self_link
}
