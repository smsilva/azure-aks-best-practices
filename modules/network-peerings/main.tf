locals {
  peerings_map = {
    for peering in var.peerings : "${peering.first}_to_${peering.second}" => peering
  }
}

module "newtork_peering" {
  for_each       = local.peerings_map
  source         = "../network-peering"
  first          = lookup(var.vnets, each.value.first, null)
  second         = lookup(var.vnets, each.value.second, null)
  resource_group = var.resource_group
}
