locals {
  subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group.name}/providers/Microsoft.Network/virtualNetworks/${var.vnet_name}/subnets/AzureBastionSubnet"
}

resource "azurerm_public_ip" "default" {
  name                = "public-ip-${var.name}"
  allocation_method   = "Static"
  sku                 = "Standard"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

resource "azurerm_bastion_host" "default" {
  name                = var.name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = local.subnet_id
    public_ip_address_id = azurerm_public_ip.default.id
  }
}
