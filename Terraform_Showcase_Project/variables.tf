variable "location" {
  description = "Azure region for resources"
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "devops-rg"
}

variable "app_service_name" {
  description = "Name of the Azure App Service"
  default     = "devops-web-app"
}

variable "sku_tier" {
  description = "Pricing tier for the App Service Plan"
  default     = "Free"
}
