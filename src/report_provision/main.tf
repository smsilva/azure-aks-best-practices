resource "null_resource" "list" {

  triggers = {
    "execution" = uuid()
  }

  provisioner "local-exec" {
    command = "./scripts/list.sh > .terraform-list.txt"
  }
}

output "file" {
  value = ".terraform-list.txt"
}
