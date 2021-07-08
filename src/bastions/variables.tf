variable "bastions" {
  default = {
    aks = {
      name        = "aks"
      subnet_name = "AzureBastionSubnet"
    }
  }
}

variable "resource_group" {
  default = {
    name     = ""
    location = ""
  }
}

variable "subnets" {
}