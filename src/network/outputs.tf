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
