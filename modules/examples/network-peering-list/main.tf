provider "azurerm" {
  features {}
}

variable "vnets" {}
variable "peerings" {}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "network" {
  source         = "../../network"
  vnets          = var.vnets
  resource_group = azurerm_resource_group.example
}

module "newtork_peering" {
  for_each       = var.peerings
  source         = "../../network-peering"
  first          = lookup(module.network.instances, each.value.first, null)
  second         = lookup(module.network.instances, each.value.second, null)
  resource_group = azurerm_resource_group.example
}

output "peerings" {
  value = module.newtork_peering
}
