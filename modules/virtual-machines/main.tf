locals {
  subnets = flatten([
    for key in keys(var.network.subnets) : [
      {
        id        = key
        name      = var.network.subnets[key].instance.name
        vnet_name = var.network.subnets[key].instance.virtual_network_name
      }
    ]
  ])

  subnets_map = {
    for subnet in local.subnets : subnet.name => {
      id        = subnet.id
      name      = subnet.name
      vnet_name = subnet.vnet_name
      subnet_id = var.network.subnets[subnet.id].instance.id
    }
  }

  vms = {
    for vm in var.vms : vm.name => {
      name        = vm.name
      subnet_name = vm.subnet_name
      subnet_id   = local.subnets_map[vm.subnet_name].subnet_id
    }
  }
}

module "virtual_machine_instances" {
  for_each       = local.vms
  source         = "../virtual-machine"
  name           = each.value.name
  subnet_id      = each.value.subnet_id
  resource_group = var.resource_group
}

//output "subnets" {
//  value = local.subnets_map
//}
//
//output "vms" {
//  value = local.vms
//}

output "instances" {
  value     = module.virtual_machine_instances
  sensitive = true
}
