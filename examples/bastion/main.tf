provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "network" {
  source         = "../../modules/network"
  vnets          = var.vnets
  resource_group = azurerm_resource_group.example
}

module "bastion" {
  source          = "../../modules/bastion"
  vnet_name       = "hub0"
  subscription_id = data.azurerm_subscription.current.subscription_id
  resource_group  = azurerm_resource_group.example
  depends_on      = [module.network]
}

output "example" {
  value = module.bastion.instance
}
