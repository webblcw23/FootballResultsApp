variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "app_service_name" {
  description = "Name of the Azure App Service"
  type        = string
}

variable "service_plan_name" {
  description = "Name of the Service Plan for the App Service"
  type        = string
}

variable "sku_tier" {
  description = "The tier of the Service Plan"
  type        = string
}

variable "sku_size" {
  description = "The size of the Service Plan"
  type        = string
}

variable "sku_name" {
  description = "The name of the Service Plan"
  type        = string
  
}

variable "os_type" {
  description = "The operating system of the Service Plan"
  type        = string
  
}
