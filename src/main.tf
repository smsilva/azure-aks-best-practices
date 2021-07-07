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

resource "null_resource" "list" {

  triggers = {
    "execution" = uuid()
  }

  provisioner "local-exec" {
    command = "./scripts/list.sh > .terraform-list.txt"
  }
}

output "resources_list" {
  value = ".terraform-list.txt"
}
