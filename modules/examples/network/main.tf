provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

variable "vnets" {}

module "network" {
  source         = "../../network"
  vnets          = var.vnets
  resource_group = azurerm_resource_group.example
}

output "vnets" {
  value = module.network.instances
}
