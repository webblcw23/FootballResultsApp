terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "my_app" {
  name = var.image_name
}

resource "docker_container" "my_app" {
  image = docker_image.my_app.name
  name  = var.container_name
  ports {
    internal = 3000
    external = 3000
  }
  volumes {
    container_path = "/app"
    host_path      = "/Users/lewiswebb/Documents/VSCode_Azure/IacTerraformProj/app"
  }
  command = ["node", "/app/server.js"]
}
