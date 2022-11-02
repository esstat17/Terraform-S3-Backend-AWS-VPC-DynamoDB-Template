# Variables in the Root Module
# Declaring an input variables
# see@ https://www.terraform.io/language/values/variables

variable "tf_environment" {
  description = "This is used in the backend.tf"
  type        = string
  default     = "Dev"
}