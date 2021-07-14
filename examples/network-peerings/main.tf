provider "azurerm" {
  features {}
}

variable "vnets" {
  default = {
    hub0 = {
      name = "vnet-hub-0"
      cidr = "10.0.0.0/20"
      subnets = [
        { cidr = "10.0.0.0/29", name = "AzureBastionSubnet" },
        { cidr = "10.0.1.0/27", name = "snet-vpn-gateway" },
        { cidr = "10.0.2.0/29", name = "snet-firewall" }
      ]
    }
    spoke100 = {
      name = "vnet-spoke-100"
      cidr = "10.100.0.0/14"
      subnets = [
        { cidr = "10.101.0.0/16", name = "snet-101" },
        { cidr = "10.102.0.0/16", name = "snet-102" },
        { cidr = "10.103.0.0/16", name = "snet-103" }
      ]
    }
  }
}

variable "peerings" {
  default = [
    { first = "hub0", second = "spoke100" }
  ]
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "network" {
  source         = "../../modules/network"
  vnets          = var.vnets
  resource_group = azurerm_resource_group.example
}

module "newtork_peerings" {
  source         = "../../modules/network-peerings"
  vnets          = module.network.instances
  peerings       = var.peerings
  resource_group = azurerm_resource_group.example
}

output "peerings" {
  value = module.newtork_peerings.peerings
}
