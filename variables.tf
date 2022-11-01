# Variables in the Root Module
# Declaring an input variables
# see@ https://www.terraform.io/language/values/variables

variable "root_name" {
  description = "This is used in the demo as fake resources"
  type        = string
  default     = "Fake VPC"
}

variable "root_cidr" {
  description = "This is used in this example module"
  type        = string
  default     = "10.123.0.0/16"
}

variable "root_tags" {
  description = "This will be used in the AWS VPC"
  type        = map(any)
  default = {
    Name = "dev"
  }
}
/*
variable "aws_access_key" {
  description = "Access key"
  type        = string
  sensitive   = true
}
variable "aws_secret_key" {
  description = "Key secret"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-west-2"
}
*/
variable "bucket_name" {
  description = "Bucket name in AWS's IAM"
  type        = string
  default     = "jenkins-terraform-state-v1"
}
variable "cidr_block" {
  description = "Classless Inter-Domain Routin block is an IP address range"
  type        = string
  default     = "172.0.0.0/16"
}



# The following variables are not used in this demo. it is just a reference only
# You can create your own format however you wish
variable "aws_vpc_str" {
  description = "The aws refers to a provider, vpc (resource type), and str (unique ID of this variable)"
  type        = string
  default     = "hello-string"
}

variable "aws_vpc_int" {
  description = "The same format above but for the integer"
  type        = number
  default     = 2
}

variable "aws_vpc_bool" {
  description = "The same format above for boolean"
  type        = bool
  default     = true
}

