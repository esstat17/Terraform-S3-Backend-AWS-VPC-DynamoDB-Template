# Terraform Configuration
# It is also know as provider.tf
# See @https://www.terraform.io/language/modules
# Usage: 
# terraform apply -var-file="s.tfvars" -auto-approve
# terraform plan -var-file="s.tfvars"
# terraform init -var-file="s.tfvars"

# Configure the AWS Provider
# See terraform registry @https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region  = "us-west-1"
  # shared_credentials_files = ["~/.aws/credentials"]
  # shared_config_files      = ["~/.aws/config"]
}

terraform {
  required_version = ">= 1.2.0"
  
  # BACKEND_BLOCK will be autofilled when you run the bash script
  ##BACKEND_BLOCK##
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
