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

output "instances" {
  value = module.network.bastions
}
