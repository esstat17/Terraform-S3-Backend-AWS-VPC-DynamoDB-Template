# Resources or Main configs of the CHILD module 
# This is the main configuration takes place,

# aws_vpc - is constant form VPC Resource see@ https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
#
/*
resource "aws_vpc" "mtc_vpc" {
  cidr_block           = var.cidr
  tags = var.tags
}
*/

# This is for demonstration purpose only
# To review the provider and documentation for the available resources and
# schemas, see: https://registry.terraform.io/providers/hashicorp/fakewebservices
resource "fakewebservices_vpc" "primary_vpc" {
  name       = var.child_name
  cidr_block = var.child_cidr
}

