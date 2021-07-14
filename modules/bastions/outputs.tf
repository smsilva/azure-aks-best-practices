output "instances" {
  value = flatten([
  for key in keys(module.bastion) : [
    lookup(module.bastion, key, null).instance
  ]
  ])
}

