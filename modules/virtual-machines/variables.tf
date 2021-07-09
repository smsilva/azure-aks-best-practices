variable "vms" {}

variable "subnets" {}

variable "resource_group" {
  default = {
    name     = ""
    location = ""
  }
}
