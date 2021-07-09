output "instance" {
  value = azurerm_virtual_network.default
}

output "vnet" {
  value = {
    id   = azurerm_virtual_network.default.id
    name = azurerm_virtual_network.default.name
  }
}

output "subnets" {
  value = {
    for snet in azurerm_virtual_network.default.subnet : snet.name => {
      name = snet.name
      id   = snet.id
    }
  }
}

output "id" {
  value = azurerm_virtual_network.default.id
}

output "name" {
  value = azurerm_virtual_network.default.name
}
