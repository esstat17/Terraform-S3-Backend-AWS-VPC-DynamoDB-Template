#Terraform output values allow you to export data from your module.
# You cannot relay information from this child module unless it is specified here.
# See docs @https://www.terraform.io/language/values

output "fake_vpc_id" {
     description = "Getting output from this child module and passing this value on to the parent output."
    value = fakewebservices_vpc.primary_vpc.id
}