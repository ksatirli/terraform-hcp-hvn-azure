terraform {
  # see https://developer.hashicorp.com/terraform/language/block/terraform#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/azuread/3.7.0/docs
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 3.7.0, < 4.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/azurerm/4.58.0/docs
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.58.0, < 5.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/hcp/0.110.0/docs
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.110.0, < 1.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/block/terraform#specifying-a-required-terraform-version
  required_version = ">= 1.12.0, < 2.0.0"
}

# Both providers must still be configured even though `create_peering = false`
# leaves them unused: Terraform initializes every provider a module declares in
# `required_providers`, and azurerm 4.x fails init without a subscription_id.
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azuread" {}
