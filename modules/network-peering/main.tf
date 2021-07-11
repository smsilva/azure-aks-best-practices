resource "azurerm_virtual_network_peering" "first" {
  name                      = "${var.first.name}_to_${var.second.name}"
  virtual_network_name      = var.first.name
  remote_virtual_network_id = var.second.id
  resource_group_name       = var.resource_group.name
}

resource "azurerm_virtual_network_peering" "second" {
  name                      = "${var.second.name}_to_${var.first.name}"
  virtual_network_name      = var.second.name
  remote_virtual_network_id = var.first.id
  resource_group_name       = var.resource_group.name
}
