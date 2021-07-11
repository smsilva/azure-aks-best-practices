output "peerings" {
  value = {
    first  = azurerm_virtual_network_peering.first
    second = azurerm_virtual_network_peering.second
  }
}
