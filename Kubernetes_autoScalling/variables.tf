variable "namespace" {
  default = "demo"
}

variable "replicas" {
  default = 2
}

variable "app_image" {
  default = "autoscaling-app:latest"
}

variable "container_port" {
  default = 3000
}

variable "min_replicas" {
  default = 1
}

variable "max_replicas" {
  default = 5
}
