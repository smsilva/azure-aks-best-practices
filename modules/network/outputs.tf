output "subnets" {
  value = module.subnets
}

output "instances" {
  value = module.vnets
}

output "peerings" {
  value = module.newtork_peerings.peerings
}

output "bastions" {
  value = module.bastions.instances
}
