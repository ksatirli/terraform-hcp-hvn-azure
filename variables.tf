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

# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn
variable "cidr_block" {
  type        = string
  description = "The CIDR range of the HVN."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name of the peer VNet in Azure."
}

variable "routing_table_cidrs" {
  type = list(object({
    name = string
    cidr = string
  }))

  description = "List of Objects containing Name and CIDR for (multiple) HVN Routing Tables."
}

variable "subscription_id" {
  type        = string
  description = "The subscription ID of the peer VNet in Azure."
}

variable "tenant_id" {
  type        = string
  description = "The tenant ID of the peer VNet in Azure."
}

variable "vnet_name" {
  type        = string
  description = "The name of the peer VNet in Azure."
}
