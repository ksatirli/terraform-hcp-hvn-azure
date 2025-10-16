terraform {
  # see https://developer.hashicorp.com/terraform/language/block/terraform#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/azuread/3.6.0
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 3.6.0, < 4.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/azurerm/4.47.0/
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.47.0, < 5.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/hcp/0.110.0/
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.110.0, < 1.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/block/terraform#specifying-a-required-terraform-version
  required_version = ">= 1.2.0, < 2.0.0"
}
