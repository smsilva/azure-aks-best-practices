terraform {
  backend "azurerm" {
    container_name       = "terraform"
    key                  = "azure-aks-best-practices.json"
    resource_group_name  = "iac"
    storage_account_name = "silvios"
  }
}

provider "azurerm" {
  features {}
}
