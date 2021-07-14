variable "network" {}
variable "resource_group" {}

locals {
  subnets_bastion_list = flatten([
    for key in keys(var.network.subnets) : [
      {
        id              = key
        vnet_name       = var.network.subnets[key].instance.virtual_network_name
        subnet_name     = var.network.subnets[key].instance.name
        subnet_instance = var.network.subnets[key].instance
      }
    ]
    if replace(var.network.subnets[key].instance.name, "AzureBastionSubnet", "") != var.network.subnets[key].instance.name
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

output "instances" {
  value = flatten([
    for key in keys(module.bastion) : [
      lookup(module.bastion, key, null).instance
    ]
  ])
}
