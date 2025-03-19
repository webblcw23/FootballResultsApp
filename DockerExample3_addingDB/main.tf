terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.14"
}

provider "docker" {}

# Docker Network
resource "docker_network" "example" {
  name = var.network_name
}

# PostgreSQL Database
resource "docker_image" "postgres" {
  name = "postgres:alpine"
}

resource "docker_container" "postgres" {
  image = docker_image.postgres.image_id
  name  = var.database_container_name
  env = [
    "POSTGRES_DB=${var.database_name}",
    "POSTGRES_USER=${var.database_user}",
    "POSTGRES_PASSWORD=${var.database_password}"
  ]
  networks_advanced {
    name = docker_network.example.name
  }
  ports {
    internal = 5432
    external = var.database_port
  }
}

# Backend Container
resource "docker_image" "backend" {
  name = "backend:local"
  build {
    context    = "${path.module}/backend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "backend" {
  image = docker_image.backend.image_id
  name  = var.backend_container_name
  env = [
    "DATABASE_URL=postgres://${var.database_user}:${var.database_password}@${var.database_container_name}:${var.database_port}/${var.database_name}"
  ]
  networks_advanced {
    name = docker_network.example.name
  }
  ports {
    internal = 3000
    external = var.backend_port
  }
}

# Frontend Container
resource "docker_image" "frontend" {
  name = "frontend:local"
  build {
    context    = "${path.module}/frontend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "frontend" {
  image = docker_image.frontend.image_id
  name  = var.frontend_container_name
  networks_advanced {
    name = docker_network.example.name
  }
  ports {
    internal = 80
    external = var.frontend_port
  }
}
