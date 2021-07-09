data "azurerm_subscription" "current" {
}

module "resource_group" {
  source   = "../modules/resource-group"
  name     = "${var.project.name}-${var.location}"
  location = var.location
}

module "network" {
  source         = "../modules/network"
  vnets          = var.vnets
  resource_group = module.resource_group.instance
}

module "bastion" {
  source          = "../modules/bastion"
  vnet_name       = "hub0"
  subscription_id = data.azurerm_subscription.current.subscription_id
  resource_group  = module.resource_group.instance
}

module "virtual_machines" {
  source         = "../modules/virtual-machines"
  vms            = var.vms
  subnets        = module.network.subnets
  resource_group = module.resource_group.instance
}

module "report_provision" {
  source = "../modules/report-provision"
}
