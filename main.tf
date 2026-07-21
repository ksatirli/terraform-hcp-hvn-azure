# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn
resource "hcp_hvn" "main" {
  hvn_id         = var.identifier
  cloud_provider = "azure"
  region         = var.region
  cidr_block     = var.cidr_block
}

locals {
  # Peering needs all four Azure identifiers. Collecting them here lets a single
  # precondition report every missing value at once, rather than failing on the
  # first null the provider happens to dereference.
  peering_inputs = {
    resource_group_name = var.resource_group_name
    subscription_id     = var.subscription_id
    tenant_id           = var.tenant_id
    vnet_name           = var.vnet_name
  }

  missing_peering_inputs = [
    for name, value in local.peering_inputs : name
    if value == null
  ]
}

resource "terraform_data" "peering_precondition" {
  count = var.create_peering ? 1 : 0

  lifecycle {
    precondition {
      condition     = length(local.missing_peering_inputs) == 0
      error_message = "create_peering is true but these inputs are null: ${join(", ", local.missing_peering_inputs)}. Set them, or set create_peering = false."
    }
  }
}

# establish a peering connection between the VPC and HVN
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/azure_peering_connection
resource "hcp_azure_peering_connection" "main" {
  count = var.create_peering ? 1 : 0

  allow_forwarded_traffic  = var.allow_forwarded_traffic
  hvn_link                 = hcp_hvn.main.self_link
  peering_id               = var.identifier
  peer_resource_group_name = var.resource_group_name
  peer_subscription_id     = var.subscription_id
  peer_tenant_id           = var.tenant_id
  peer_vnet_name           = var.vnet_name
  peer_vnet_region         = var.region
  use_remote_gateways      = var.use_remote_gateways
}

locals {
  client_id = var.create_peering ? hcp_azure_peering_connection.main[0].application_id : null

  role_identifier = var.create_peering ? join("-", [
    "hcp-hvn-peering-access",
    local.client_id
  ]) : null

  vnet_identifier = var.create_peering ? "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.vnet_name}" : null
}

# create Active Directory Service Principal for HVN
# see https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal
resource "azuread_service_principal" "main" {
  count = var.create_peering ? 1 : 0

  client_id = local.client_id
}

resource "azurerm_role_definition" "main" {
  count = var.create_peering ? 1 : 0

  name        = local.role_identifier
  description = "Terraform-managed Role Definition for HCP HVN Service Principal."
  scope       = local.vnet_identifier

  assignable_scopes = [
    local.vnet_identifier
  ]

  permissions {
    actions = [
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/peer/action",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/read",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write",
    ]
  }
}

# assign role definition to Service Principal
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "role_assignment" {
  count = var.create_peering ? 1 : 0

  description        = "Terraform-managed Role Assignment for HCP HVN Service Principal."
  principal_id       = azuread_service_principal.main[0].object_id
  role_definition_id = azurerm_role_definition.main[0].role_definition_resource_id
  scope              = local.vnet_identifier
}

# wait for previous resource (`hcp_azure_peering_connection`) to become active, before continuing operations using data source
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/azure_peering_connection
# data "hcp_azure_peering_connection" "main" {
#   hvn_link              = hcp_hvn.main.self_link
#   peering_id            = hcp_azure_peering_connection.main.peering_id
#   wait_for_active_state = false
# }

# create route for HVN
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn_route
resource "hcp_hvn_route" "main" {
  for_each = var.create_peering ? {
    for cidr in var.routing_table_cidrs :
    cidr.name => cidr
  } : {}

  hvn_link         = hcp_hvn.main.self_link
  hvn_route_id     = "${var.identifier}-${each.key}"
  destination_cidr = each.value.cidr
  target_link      = hcp_azure_peering_connection.main[0].self_link
}
