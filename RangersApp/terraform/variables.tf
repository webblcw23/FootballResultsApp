
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
