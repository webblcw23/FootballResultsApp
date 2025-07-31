# This page retrieves the variables from the other modules (vpc) outputs.tf
variable "sn" {
  description = "Subnet ID"
  type        = string
}

variable "sg" {
  description = "Security Group ID"
  type        = string
}