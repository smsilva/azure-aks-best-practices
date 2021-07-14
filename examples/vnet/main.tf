provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "vnet_example" {
  source         = "../../modules/vnet"
  name           = "vnet-example"
  cidr           = ["10.0.0.0/20"]
  resource_group = azurerm_resource_group.example
}

output "instance" {
  value = module.vnet_example.instance
}
