variable "network" {}
variable "resource_group" {}

locals {
  vnet_bastion_list = flatten([
    for key in keys(var.network.subnets) : [
      {
        id          = key
        subnet_name = var.network.subnets[key].instance.name
      }
      //      for subnet in var.network.subnets : var.network.subnets[key].instance.name
    ]
    if var.network.subnets[key].instance.name == "snet-102"
  ])
}

output "vnet_bastion_list" {
  value = local.vnet_bastion_list
}
