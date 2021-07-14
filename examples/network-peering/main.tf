provider "azurerm" {
  features {}
}

variable "vnets" {}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "network" {
  source         = "../../modules/network"
  vnets          = var.vnets
  resource_group = azurerm_resource_group.example
}

module "newtork-peering" {
  source         = "../../modules/network-peering"
  first          = lookup(module.network.instances, "hub0", null)
  second         = lookup(module.network.instances, "spoke100", null)
  resource_group = azurerm_resource_group.example
}

output "peerings" {
  value = module.newtork-peering.peerings
}
