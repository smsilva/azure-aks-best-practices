variable "name" {
  default = ""
}

variable "resource_group" {
  default = {
    name     = ""
    location = ""
  }
}

variable "subnet_id" {
  default = ""
}
