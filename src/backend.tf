terraform {
  required_version = ">= 1, < 2"

  backend "azurerm" {
    resource_group_name  = "iac"
    storage_account_name = "silvios"
    container_name       = "terraform"
    key                  = "azure-aks-best-practices.json"
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2, <3"
    }
  }
}

provider "azurerm" {
  features {}
}
