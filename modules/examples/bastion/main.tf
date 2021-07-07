provider "azurerm" {
  features {}
}

locals {
  vnet = {
    subnets = {
      for subnet in [
        { cidr = "10.0.1.0/29", name = "AzureBastionSubnet" }
      ] : "${subnet.name}" => subnet
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "vnet" {
  source         = "../../vnet"
  name           = "vnet-example"
  cidr           = ["10.0.0.0/20"]
  resource_group = azurerm_resource_group.example
}

module "subnets" {
  for_each       = local.vnet.subnets
  source         = "../../subnet"
  name           = each.value.name
  cidrs          = [each.value.cidr]
  vnet           = module.vnet
  resource_group = azurerm_resource_group.example
}

module "bastion_example" {
  source         = "../../bastion"
  name           = "aks"
  subnet_id      = module.subnets["AzureBastionSubnet"].snet.id
  resource_group = azurerm_resource_group.example
}

output "bastion" {
  value = module.bastion_example.bastion
}
