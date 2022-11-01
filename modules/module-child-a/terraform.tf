# Terraform Configuration
# It is also know as provider.tf
# See @https://www.terraform.io/language/modules

# Configure the AWS Provider
# See terraform registry @https://registry.terraform.io/providers/hashicorp/aws/latest/docs
/*
provider "aws" {
  region                   = "us-west-2"
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files      = ["~/.aws/config"]
  profile                  = "demo2"
}
*/

terraform {
  required_version = ">= 1.2.0"
  /*
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  */
}