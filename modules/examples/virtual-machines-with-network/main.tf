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
  source         = "../../network"
  vnets          = var.vnets
  peerings       = var.peerings
  resource_group = azurerm_resource_group.example
}

module "virtual_machines" {
  source         = "../../virtual-machines"
  vms            = var.vms
  network        = module.network
  resource_group = azurerm_resource_group.example
}

//output "subnets" {
//  value = module.virtual_machines.subnets
//}
//
//output "vms" {
//  value = module.virtual_machines.vms
//}

output "instances" {
  value     = module.virtual_machines.instances
  sensitive = true
}
