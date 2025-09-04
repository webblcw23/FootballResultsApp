#varibles for terraform to azure

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
  default     = "rangersdockeracr"
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

# variables.tf
variable "client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Client Secret"
  sensitive   = true
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "devops_sp_object_id" {
  type        = string
  description = "Object ID of the Azure DevOps Service Principal"
}

variable "acr_password" {
  type        = string
  description = "Password for the Azure Container Registry"
  sensitive   = true
}

variable "image_name" {
  type        = string
  description = "Docker image name"
  default     = "rangersappimage"
}

variable "docker_registry_url" {
  type        = string
  description = "Docker registry URL"
  default     = "rangersdockeracr.azurecr.io"

}
