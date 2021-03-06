provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

locals {
  subnets = [
    { cidr = "10.0.1.0/28", name = "snet-vm-example" }
  ]

  subnets_map = {
    for subnet in local.subnets : subnet.name => subnet
  }
}

module "vnet" {
  source = "../../modules/vnet"

  name           = "vnet-hub-example"
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

module "virtual_machine" {
  source         = "../../modules/virtual-machine"
  name           = "vm-hub-1"
  subnet_id      = module.subnets["snet-vm-example"].instance.id
  resource_group = azurerm_resource_group.example
}
