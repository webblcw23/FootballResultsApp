#varibles for terraform to azure

#client id
variable "client_id" {
  description = "The Client ID for the Azure Service Principal."
  type        = string
}   

#client secret
variable "client_secret" {
  description = "The Client Secret for the Azure Service Principal."
  type        = string
  sensitive   = true
}

#subscription id
variable "subscription_id" {
  description = "The Subscription ID for the Azure Subscription."
  type        = string
}

#tenant id
variable "tenant_id" {
  description = "The Tenant ID for the Azure Active Directory."
  type        = string
}

#resource group name
variable "resource_group_name" {
  description = "The name of the Resource Group to create."
  type        = string
  default     = "rg-rangers-app"
}

#location
variable "location" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "UK South"
}

#container registry name
variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
  default     = "rangersdockerarc"
}

#app service plan name
variable "app_service_plan_name" {
    description = "The name of the App Service Plan."
    type        = string
    default     = "rangers-asp"
}

#web app name
variable "web_app_name" {
    description = "The name of the Web App."
    type        = string
    default     = "rangers-webapp"
}