provider "azurerm" {
  features {}
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

module "bastions" {
  source         = "../../modules/bastions"
  network        = module.network
  resource_group = azurerm_resource_group.example
}

output "vnet_bastion_list" {
  value = module.bastions.vnet_bastion_list
}
