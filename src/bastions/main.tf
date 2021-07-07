locals {
  bastions = flatten([
    for key in keys(var.bastions) : [
      {
        name        = key
        subnet_name = var.bastions[key].subnet_name
      }
    ]
  ])

  bastions_map = {
    for bastion in local.bastions : "${bastion.name}" => bastion
  }
}

module "bastions" {
  for_each       = local.bastions_map
  source         = "../../modules/bastion"
  name           = each.value.name
  subnet_id      = each.value.subnet_name
  resource_group = var.resource_group
}

output "list" {
  value = local.bastions_map
}
