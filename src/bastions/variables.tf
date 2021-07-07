variable "bastions" {
  default = {
    aks = {
      name = "bastion-aks"
      subnet_id = ""
    }
  }
}
