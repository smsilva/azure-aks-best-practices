output "vnets" {
  value = local.vnets
}

output "snets" {
  value = local.subnets
}

output "subnets_map" {
  value = local.subnets_map
}

output "subnets" {
  value = module.subnets
}

output "instances" {
  value = module.vnets
}

output "peerings" {
  value = module.newtork_peerings.peerings
}

output "vnet_bastion_list" {
  value = local.vnet_bastion_list
}

output "bastions" {
  value = module.bastions.instances
}
