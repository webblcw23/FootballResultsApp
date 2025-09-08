

variable "image_name" {
  type    = string
  default = "rangersapp"
}

variable "docker_registry_url" {
  type    = string
  default = "https://rangersdockeracr.azurecr.io"
}


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
