# This file defines the variables used in the Terraform configuration for the EndToEnd project.

variable "resource_group_name" {
  type        = string
  default     = "EndToEndProjectRG"
  description = "Name of the Azure Resource Group"
}

variable "location" {
  type        = string
  default     = "UK South"
  description = "Location for all resources"
}

variable "prefix" {
  type        = string
  default     = "demo"
  description = "Prefix to use for naming resources"
}
