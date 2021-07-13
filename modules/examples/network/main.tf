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
  peerings       = var.peerings
  resource_group = azurerm_resource_group.example
}

output "instances" {
  value = module.network.instances
}

output "peerings" {
  value = module.network.peerings
}
