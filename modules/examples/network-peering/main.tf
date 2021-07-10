provider "azurerm" {
  features {}
}

variable "vnets" {}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "network" {
  source         = "../../network"
  vnets          = var.vnets
  resource_group = azurerm_resource_group.example
}

module "newtork-peering" {
  source         = "../../network-peering"
  first          = module.network.instances.hub0
  second         = module.network.instances.spoke100
  resource_group = azurerm_resource_group.example
}

output "instances" {
  value = module.newtork-peering.peerings
}
