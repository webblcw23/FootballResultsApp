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
    internal = 5001
    external = 5001
  }
  volumes {
  container_path = "/app"
  host_path      = abspath("${path.module}/app")
}
  command = ["node", "/app/server.js"]
}

resource "docker_image" "postgres" {
  name = "postgres:latest"
}

resource "docker_container" "postgres_db" {
  image = docker_image.postgres.name
  name  = "local-postgres-db"
  ports {
    internal = 5432
    external = 5432
  }
  env =[
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=password",
    "POSTGRES_DB=mydb"
  ]
  volumes {
    container_path = "/var/lib/postgresql/data"
    host_path      = abspath("${path.module}/db_data")
  }
}

