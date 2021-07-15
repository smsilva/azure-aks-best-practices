provider "azurerm" {
  features {}
}

variable "subnets" {
  default = [
    { cidr = "10.0.1.0/29", name = "AzureBastionSubnet" },
    { cidr = "10.0.2.0/27", name = "snet-vpn-gateway" },
    { cidr = "10.0.3.0/29", name = "snet-firewall" },
  ]
}

locals {
  subnets_map = {
    for subnet in var.subnets : subnet.name => subnet
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "vnet" {
  source         = "../../modules/vnet"
  name           = "vnet-hub-example"
  cidr           = ["10.0.0.0/20"]
  resource_group = azurerm_resource_group.example
}

module "subnets" {
  for_each       = local.subnets_map
  source         = "../../modules/subnet"
  name           = each.value.name
  cidrs          = [each.value.cidr]
  vnet           = module.vnet.instance
  resource_group = azurerm_resource_group.example
}

output "instances" {
  value = module.subnets
}
