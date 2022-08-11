# configure the Azure AD provider using a data source from the AzureRM provider
# see https://registry.terraform.io/providers/hashicorp/azuread/latest/docs
provider "azuread" {
  tenant_id = data.azurerm_subscription.main.tenant_id
}


# The HCP Provider is set to retrieve configuration from the executing environment
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#example-usage
provider "azurerm" {
  environment = var.environment

  features {}
}

# The HCP Provider is set to retrieve configuration from the executing environment
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs#schema
provider "hcp" {}
