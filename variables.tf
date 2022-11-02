# Variables in the Root Module
# Declaring an input variables
# see@ https://www.terraform.io/language/values/variables

variable "vpc_name" {
  description = "default name used in main.tf"
  type        = string
  default     = "yourappname"
}
variable "tf_environment" {
  description = "This is used in the backend.tf"
  type        = string
  default     = "Dev"
}
variable "cidr_block" {
  description = "Classless Inter-Domain Routin block is an IP address range"
  type        = string
  default     = "172.0.0.0/16"
}