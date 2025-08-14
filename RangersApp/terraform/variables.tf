
variable "resource_group_name" {
  type        = string
  default     = "FootballScoresRG"
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  default     = "UK South"
  description = "Azure region"
}

variable "acr_name" {
  type        = string
  default     = "rangersacr"
}

variable "app_service_plan_name" {
  type        = string
  default     = "rangers-asp"
}

variable "web_app_name" {
  type        = string
  default     = "rangers-webapp"
}

variable "docker_image_tag" {
  type        = string
  default     = "latest"
}

#Pipeline connection variables from Azure DevOps to Azure

variable "client_id" {
  description = "Azure service principal client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure service principal client secret"
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
    default     = "91c0fe80-4528-4bf2-9796-5d0f2a250518"
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
    default     = "f0445b33-db6a-455d-8714-59168c138593"
}
