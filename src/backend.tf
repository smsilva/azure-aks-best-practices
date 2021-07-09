terraform {
  backend "azurerm" {
    resource_group_name  = "iac"
    storage_account_name = "silvios"
    container_name       = "terraform"
    key                  = "azure-aks-best-practices.json"
  }
}

provider "azurerm" {
  features {}
}
