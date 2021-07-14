
locals {
  subnets_bastion_list = flatten([
    for key in keys(var.subnets) : [
      {
        id              = key
        vnet_name       = var.subnets[key].instance.virtual_network_name
        subnet_name     = var.subnets[key].instance.name
        subnet_instance = var.subnets[key].instance
      }
    ]
    if replace(var.subnets[key].instance.name, "AzureBastionSubnet", "") != var.subnets[key].instance.name
  ])

  bastion_map = {
    for item in local.subnets_bastion_list : item.id => item
  }
}

module "bastion" {
  for_each       = local.bastion_map
  source         = "../bastion"
  name           = each.value.vnet_name
  subnet         = each.value.subnet_instance
  resource_group = var.resource_group
}
