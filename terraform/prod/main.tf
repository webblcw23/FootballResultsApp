provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rangers_rg_prod" {
  name     = "rg-rangers-prod"
  location = "UK South"
}

resource "azurerm_service_plan" "rangers_plan_prod" {
  name                = "rangers-plan-prod"
  location            = azurerm_resource_group.rangers_rg_prod.location
  resource_group_name = azurerm_resource_group.rangers_rg_prod.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "rangers_webapp_prod" {
  name                = "rangers-webapp-prod"
  location            = azurerm_resource_group.rangers_rg_prod.location
  resource_group_name = azurerm_resource_group.rangers_rg_prod.name
  service_plan_id     = azurerm_service_plan.rangers_plan_prod.id
  https_only = true  # 🔐 Enforces HTTPS for secure web app 

  site_config {
    application_stack {
      docker_image_name   = "${var.image_name}:${var.image_tag}"
      docker_registry_url = "https://rangersdockeracr.azurecr.io"
    }
          container_registry_use_managed_identity = true
  }

  identity {
    type = "SystemAssigned"
  }

   app_settings = {
    "WEBSITES_PORT" = "80"
      docker_registry_url = "https://rangersdockeracr.azurecr.io"
  }
}


resource "azurerm_role_assignment" "acr_pull_prod" {
  principal_id         = azurerm_linux_web_app.rangers_webapp_prod.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = "/subscriptions/91c0fe80-4528-4bf2-9796-5d0f2a250518/resourceGroups/rg-rangers-core/providers/Microsoft.ContainerRegistry/registries/rangersdockeracr"
}


# To allow for the web app restart
resource "azurerm_role_assignment" "prod_webapp_rbac" {
  principal_id         = "d0d5257b-bb1a-4272-b552-98a508458f5f" # Federated identity object ID
  role_definition_name = "Contributor"
  scope                = "/subscriptions/91c0fe80-4528-4bf2-9796-5d0f2a250518/resourceGroups/rg-rangers-aks"
}







