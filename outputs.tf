#Terraform output values allow you to export data from your module.
# See docs @https://www.terraform.io/language/values

output "fake_vpc_id_from_child_module" {
  description = "Getting output from child module."
  value       = module.your_root_module.fake_vpc_id
}