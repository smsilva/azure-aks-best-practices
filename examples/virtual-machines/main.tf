provider "azurerm" {
  features {}
}

variable "vnets" {}
variable "peerings" {}
variable "vms" {}

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

module "virtual_machines" {
  source         = "../../modules/virtual-machines"
  vms            = var.vms
  network        = module.network
  resource_group = azurerm_resource_group.example
}

output "instances" {
  value     = module.virtual_machines.instances
  sensitive = true
}
