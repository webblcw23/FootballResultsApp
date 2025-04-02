# Kubernetes Provider Configuration
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Namespace Definition
resource "kubernetes_namespace" "demo_namespace" {
  metadata {
    name = "demo"
  }
}

# Deployment Definition
resource "kubernetes_deployment" "app_deployment" {
  depends_on = [kubernetes_namespace.demo_namespace]

  metadata {
    name      = "autoscaling-app"
    namespace = kubernetes_namespace.demo_namespace.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "autoscaling-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "autoscaling-app"
        }
      }

      spec {
        container {
          name  = "app-container"
          image = "autoscaling-app:latest"

          resources {
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
          }

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

# Service Definition
resource "kubernetes_service" "app_service" {
  metadata {
    name      = "autoscaling-app-service"
    namespace = kubernetes_namespace.demo_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "autoscaling-app"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "NodePort"
  }
}

# Horizontal Pod Autoscaler (HPA) Definition
resource "kubernetes_horizontal_pod_autoscaler" "app_hpa" {
  depends_on = [kubernetes_deployment.app_deployment]

  metadata {
    name      = "autoscaling-app-hpa"
  }

  spec {
    scale_target_ref {
      kind        = "Deployment"
      name        = kubernetes_deployment.app_deployment.metadata[0].name
      api_version = "apps/v1"
    }

    min_replicas = 1
    max_replicas = 5

    metric {
      type = "Resource"

      resource {
        name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = 50
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      metadata,
      spec
    ]
  }
}
