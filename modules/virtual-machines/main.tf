locals {
  vms = {
    for vm in var.vms : "${vm.name}" => {
      name      = vm.name
      subnet_id = var.subnets["${vm.subnet_name}"].instance.id
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
