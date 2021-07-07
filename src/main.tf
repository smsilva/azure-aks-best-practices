module "resource_group" {
  source   = "./resource-group"
  name     = "${var.project.name}-${var.location}"
  location = var.location
}

module "network" {
  source         = "./vnets"
  vnets          = var.vnets
  location       = var.location
  resource_group = module.resource_group.resource_group
}

module "bastions" {
  source         = "./bastions"
  resource_group = module.resource_group.resource_group
}

module "report_provision" {
  source = "./report_provision"
}

output "bastions" {
  value = module.bastions.list
}

output "resources_list" {
  value = module.report_provision.file
}
