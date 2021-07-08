variable "name" {
  description = "Virtual Machine Name"
  default     = ""
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
