terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Docker Network
resource "docker_network" "example" {
  name = "example_network"
}

# Frontend Service
resource "docker_image" "frontend" {
  name = "frontend:local"
  build {
    context    = "${path.module}/frontend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "frontend" {
  image = docker_image.frontend.image_id
  name  = "frontend-container"
  networks_advanced {
    name = docker_network.example.name
  }
  ports {
    internal = 80
    external = 8080
  }
}

# Backend Service
resource "docker_image" "backend" {
  name = "backend:local"
  build {
    context    = "${path.module}/backend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "backend" {
  image = docker_image.backend.image_id
  name  = "backend-container"
  networks_advanced {
    name = docker_network.example.name
  }
  ports {
    internal = 3000
    external = 3000
  }
}
