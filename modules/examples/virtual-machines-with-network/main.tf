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

//module "virtual_machines" {
//  source         = "../../virtual-machines"
//  vms            = var.vms
//  subnets        = module.network.subnets
//  resource_group = azurerm_resource_group.example
//}

output "subnets" {
  value = module.network.subnets
}

//output "instances" {
//  value     = module.virtual_machines.instances
//  sensitive = true
//}
