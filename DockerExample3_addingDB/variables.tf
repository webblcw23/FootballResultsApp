variable "network_name" {
  description = "Name of the Docker network"
  type        = string
  default     = "example_network"
}

variable "frontend_container_name" {
  description = "Name of the frontend container"
  type        = string
  default     = "frontend-container"
}

variable "backend_container_name" {
  description = "Name of the backend container"
  type        = string
  default     = "backend-container"
}

variable "database_container_name" {
  description = "Name of the database container"
  type        = string
  default     = "database"
}

variable "database_user" {
  description = "Database username"
  type        = string
  default     = "postgres"
}

variable "database_password" {
  description = "Database password"
  type        = string
  default     = "password"
}

variable "database_name" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "appdb"
}

variable "frontend_port" {
  description = "Port mapping for the frontend container"
  type        = number
  default     = 8080
}

variable "backend_port" {
  description = "Port mapping for the backend container"
  type        = number
  default     = 3000
}

variable "database_port" {
  description = "Port mapping for the database container"
  type        = number
  default     = 5432
}
