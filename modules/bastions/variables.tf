variable "bastions" {
  default = []
}

variable "resource_group" {
  default = {
    name     = ""
    location = ""
  }
}

variable "subnets" {
}
