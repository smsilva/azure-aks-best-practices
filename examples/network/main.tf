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
  source         = "../../modules/network"
  vnets          = var.vnets
  peerings       = var.peerings
  resource_group = azurerm_resource_group.example
}

output "bastions" {
  value = module.network.bastions
}

output "instances" {
  value = module.network.instances
}

output "peerings" {
  value = module.network.peerings
}
