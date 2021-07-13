locals {
  vnets = flatten([
    for key in keys(var.vnets) : [
      {
        id   = key
        name = var.vnets[key].name
        cidr = var.vnets[key].cidr
      }
    ]
  ])

  vnets_map = {
    for vnet in local.vnets : vnet.id => vnet
  }

  subnets = flatten([
    for key in keys(var.vnets) : [
      for subnet in var.vnets[key].subnets : {
        name = subnet.name
        cidr = subnet.cidr
        vnet = {
          id   = key
          name = var.vnets[key].name
          cidr = var.vnets[key].cidr
        }
      }
    ]
  ])

  subnets_map = {
    for subnet in local.subnets : "${subnet.vnet.name}_${subnet.name}" => subnet
  }

  vnet_bastion_list = flatten([
    for key in keys(var.vnets) : [
      for subnet in var.vnets[key].subnets : var.vnets[key].name
      if subnet.name == "AzureBastionSubnet"
    ]
  ])
}

data "azurerm_subscription" "current" {
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
  vnet           = module.vnets[each.value.vnet.id].instance
  resource_group = var.resource_group
}

module "newtork_peerings" {
  source         = "../network-peerings"
  vnets          = module.vnets
  peerings       = var.peerings
  resource_group = var.resource_group
}

module "bastions" {
  for_each        = module.vnets
  source          = "../bastion"
  name            = "bastion-${each.value.instance.name}"
  vnet_name       = each.value.instance.name
  subscription_id = data.azurerm_subscription.current.subscription_id
  resource_group  = var.resource_group
  depends_on      = [module.vnets, module.subnets]
}
