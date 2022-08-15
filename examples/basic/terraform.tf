terraform {
  # see https://www.terraform.io/docs/language/settings/index.html#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/azuread/2.27.0
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.27.0, < 3.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/azurerm/3.18.0/
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.18.0, < 4.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/hcp/0.39.0/
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.40.0, < 1.0.0"
    }
  }

  # see https://www.terraform.io/docs/language/settings/index.html#specifying-a-required-terraform-version
  required_version = ">= 1.2.0"
}
