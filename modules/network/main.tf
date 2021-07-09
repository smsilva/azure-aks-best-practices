locals {
  vnets = flatten([
    for key in keys(var.vnets) : [
      {
        name = key
        cidr = var.vnets[key].cidr
      }
    ]
  ])

  subnets = flatten([
    for key in keys(var.vnets) : [
      for subnet in var.vnets[key].subnets : {
        name = subnet.name
        cidr = subnet.cidr
        vnet = {
          name = key
          cidr = var.vnets[key].cidr
        }
      }
    ]
  ])

  vnets_map = {
    for vnet in local.vnets : "${vnet.name}" => vnet
  }

  subnets_map = {
    for subnet in local.subnets : "${subnet.name}" => subnet
  }
}

module "vnets" {
  for_each       = local.vnets_map
  source         = "../vnet"
  name           = each.value.name
  cidr           = [each.value.cidr]
  resource_group = var.resource_group
}

module "subnets" {
  for_each       = local.subnets_map
  source         = "../subnet"
  name           = each.value.name
  cidrs          = [each.value.cidr]
  vnet           = module.vnets[each.value.vnet.name].vnet
  resource_group = var.resource_group
}

resource "azurerm_virtual_network_peering" "hub0_to_spoke100" {
  name                      = "hub0_to_spoke100"
  resource_group_name       = var.resource_group.name
  virtual_network_name      = module.vnets["hub0"].vnet.name
  remote_virtual_network_id = module.vnets["spoke100"].vnet.id
}

resource "azurerm_virtual_network_peering" "spoke100_to_hub0" {
  name                      = "spoke100_to_hub0"
  resource_group_name       = var.resource_group.name
  virtual_network_name      = module.vnets["spoke100"].vnet.name
  remote_virtual_network_id = module.vnets["hub0"].vnet.id
}
