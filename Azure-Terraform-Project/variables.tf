variable "rg_name" {
  type        = string
  description = "The name of the Resource Group"
  default     = "rg-demo-lab"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
  default     = "uksouth"
}

variable "storage_account_name" {
  type        = string
  description = "Unique name for the storage account (lowercase, 3-24 chars)"
  default     = "demostoragewebb01"
}
