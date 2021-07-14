provider "azurerm" {
  features {}
}

locals {
  subnets = [
    { cidr = "10.0.1.0/28", name = "snet-1" },
    { cidr = "10.0.2.0/28", name = "snet-2" }
  ]

  subnets_map = {
    for subnet in local.subnets : subnet.name => subnet
  }

  vms = [
    { name = "vm-1", subnet_name = "snet-1" },
    { name = "vm-2", subnet_name = "snet-2" },
  ]
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "vnet" {
  source         = "../../modules/vnet"
  name           = "vnet-example"
  cidr           = ["10.0.0.0/20"]
  resource_group = azurerm_resource_group.example
}

module "subnets" {
  for_each       = local.subnets_map
  source         = "../../modules/subnet"
  name           = each.value.name
  cidrs          = [each.value.cidr]
  vnet           = module.vnet
  resource_group = azurerm_resource_group.example
}

module "virtual_machines" {
  source         = "../../modules/virtual-machines"
  vms            = local.vms
  subnets        = module.subnets
  resource_group = azurerm_resource_group.example
}

output "instances" {
  value     = module.virtual_machines.instances
  sensitive = true
}
