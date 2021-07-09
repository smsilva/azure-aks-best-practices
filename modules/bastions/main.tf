locals {
  bastions_map = {
    for bastion in var.bastions : "${bastion}" => {
      name        = bastion
      subnet_name = "AzureBastionSubnet"
    }
  }
}

module "bastions" {
  for_each       = local.bastions_map
  source         = "../bastion"
  name           = each.value.name
  subnet_id      = var.subnets[each.value.subnet_name].instance.id
  resource_group = var.resource_group
}
