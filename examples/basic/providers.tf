# configure the Azure AD provider using a data source from the AzureRM provider
# see https://registry.terraform.io/providers/hashicorp/azuread/3.9.0/docs
provider "azuread" {
  tenant_id = data.azurerm_subscription.main.tenant_id
}


# The AzureRM provider is set to retrieve configuration from the executing environment
# see https://registry.terraform.io/providers/hashicorp/azurerm/4.58.0/docs#example-usage
provider "azurerm" {
  environment = var.environment

  features {}
}

# The HCP Provider is set to retrieve configuration from the executing environment
# see https://registry.terraform.io/providers/hashicorp/hcp/0.114.0/docs#schema
provider "hcp" {}
