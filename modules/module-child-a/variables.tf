# Variables in the Child Module

variable "child_name" {
  description = "This is used in the demo as fake resources"
  type        = string
}

variable "child_cidr" {
  description = "This is used in this example module"
  type        = string
}

variable "child_tags" {
  description = "This is also used in the example module"
  type        = map(any)
  default     = {}
}