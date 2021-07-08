output "bastions" {
  value = module.bastions.list
}

output "resources_list" {
  value = module.report_provision.file
}
