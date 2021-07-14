vnets = {
  hub0 = {
    name = "vnet-hub-0"
    cidr = "10.0.0.0/20"
    subnets = [
      { cidr = "10.0.0.0/29", name = "AzureBastionSubnet" },
      { cidr = "10.0.1.0/27", name = "snet-1" },
      { cidr = "10.0.2.0/29", name = "snet-2" }
    ]
  }
  spoke100 = {
    name = "vnet-spoke-100"
    cidr = "10.100.0.0/14"
    subnets = [
      { cidr = "10.100.0.0/29", name = "AzureBastionSubnet" },
      { cidr = "10.101.0.0/16", name = "snet-101" },
      { cidr = "10.102.0.0/16", name = "snet-102" }
    ]
  }
}
