provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "vnet" {
  source         = "../../modules/vnet"
  name           = "vnet-hub-example"
  cidr           = ["10.0.0.0/20"]
  resource_group = azurerm_resource_group.example
}

module "subnet" {
  source         = "../../modules/subnet"
  name           = "AzureBastionSubnet"
  cidrs          = ["10.0.1.0/29"]
  vnet           = module.vnet.instance
  resource_group = azurerm_resource_group.example
}

module "bastion" {
  source         = "../../modules/bastion"
  name           = "hub0"
  subnet         = module.subnet.instance
  resource_group = azurerm_resource_group.example
}

output "bastion" {
  value = module.bastion.instance
}
