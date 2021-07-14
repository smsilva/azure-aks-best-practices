module "resource_group" {
  source   = "../modules/resource-group"
  name     = "${var.project.name}-${var.location}"
  location = var.location
}

module "network" {
  source         = "../modules/network"
  vnets          = var.vnets
  peerings       = var.peerings
  resource_group = module.resource_group.instance
}

module "virtual_machines" {
  source         = "../modules/virtual-machines"
  vms            = var.vms
  network        = module.network
  resource_group = module.resource_group.instance
}

module "report_provision" {
  source     = "../modules/report-provision"
  depends_on = [module.virtual_machines]
}
