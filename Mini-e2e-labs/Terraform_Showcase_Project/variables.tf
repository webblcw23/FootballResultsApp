variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "app_service_name" {
  description = "Name of the Azure App Service"
  type        = string
}

variable "service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "sku_tier" {
  description = "The tier of the Service Plan"
  default     = "Free"
}

variable "sku_size" {
  description = "The size of the Service Plan"
  default     = "F1"
}
