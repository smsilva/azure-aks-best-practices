locals {
  bastions = flatten([
    for key in keys(var.bastions) : [
      {
        name      = key
        subnet_id = var.vnets[key].subnet_id
      }
    ]
  ])

  bastions_map = {
    for bastion in local.bastions : "${bastions.name}" => bastion
  }
}

module "bastions" {
  for_each       = local.vnets_map
  source         = "../../modules/bastion"
  name           = each.value.name
  subnet_id      = each.value.subnet_id
  resource_group = azurerm_resource_group.example
}

output "bastions" {
  value = module.bastions.bastion
}
