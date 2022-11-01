# Resources or Main configs of the ROOT module 
# This is the main configuration takes place
# See Resources and Modules docs on Terraform Registry

# Simple AWS PVC
# See more options https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "app_main_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "App-Main-VPC"
  }
}