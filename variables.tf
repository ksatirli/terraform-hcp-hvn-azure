variable "allow_forwarded_traffic" {
  type        = bool
  description = "Whether to allow forwarded traffic from the HVN to the peer VNet."
  default     = false
}

variable "region" {
  type        = string
  description = "Azure Region to deploy HVN in."

  # To create a peering connection between an HVN and your VPC,
  # `region` must reflect the currently supported HCP region.
  validation {
    condition = contains([
      # Iowa,      Virginia, Virginia,  Washington
      "centralus", "eastus", "eastus2", "westus2",

      # Paris,         # Ireland,     # Netherlands, London
      "francecentral", "northeurope", "westeurope", "uksouth"
    ], var.region)
    error_message = "`region` must be in a supported region."
  }
}

variable "identifier" {
  type        = string
  description = "The ID of the HashiCorp Virtual Network (HVN)."
}

# see https://registry.terraform.io/providers/hashicorp/hcp/0.114.0/docs/resources/hvn
variable "cidr_block" {
  type        = string
  description = "The CIDR range of the HVN."
}

variable "create_peering" {
  default     = true
  description = "Whether to create an Azure VNet peering connection, its Service Principal, Role Definition, Role Assignment, and HVN routes. Set to `false` to provision a standalone HVN with no Azure connectivity (for example, when the HVN backs a cluster reached over a public endpoint). When `false`, `resource_group_name`, `routing_table_cidrs`, `subscription_id`, `tenant_id`, and `vnet_name` are ignored."
  type        = bool
}

variable "resource_group_name" {
  default     = null
  description = "The resource group name of the peer VNet in Azure. Required when `create_peering` is `true`."
  nullable    = true
  type        = string
}

variable "routing_table_cidrs" {
  default     = []
  description = "List of Objects containing Name and CIDR for (multiple) HVN Routing Tables. Ignored when `create_peering` is `false`."
  nullable    = false

  type = list(object({
    name = string
    cidr = string
  }))
}

variable "subscription_id" {
  default     = null
  description = "The subscription ID of the peer VNet in Azure. Required when `create_peering` is `true`."
  nullable    = true
  type        = string
}

variable "tenant_id" {
  default     = null
  description = "The tenant ID of the peer VNet in Azure. Required when `create_peering` is `true`."
  nullable    = true
  type        = string
}

variable "vnet_name" {
  default     = null
  description = "The name of the peer VNet in Azure. Required when `create_peering` is `true`."
  nullable    = true
  type        = string
}

variable "use_remote_gateways" {
  type        = bool
  description = "Whether to use remote gateways for the peering connection."
  default     = false
}
