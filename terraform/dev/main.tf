provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}


resource "azurerm_resource_group" "rangers_rg_dev" {
  name     = "rg-rangers-dev"
  location = "UK South"
}

resource "azurerm_service_plan" "rangers_plan_dev" {
  name                = "rangers-plan-dev"
  location            = azurerm_resource_group.rangers_rg_dev.location
  resource_group_name = azurerm_resource_group.rangers_rg_dev.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "rangers_webapp_dev" {
  name                = "rangers-webapp-dev"
  location            = azurerm_resource_group.rangers_rg_dev.location
  resource_group_name = azurerm_resource_group.rangers_rg_dev.name
  service_plan_id     = azurerm_service_plan.rangers_plan_dev.id

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
  }
}


resource "azurerm_role_assignment" "acr_pull_dev" {
  principal_id         = azurerm_linux_web_app.rangers_webapp_dev.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = "/subscriptions/91c0fe80-4528-4bf2-9796-5d0f2a250518/resourceGroups/rg-rangers-core/providers/Microsoft.ContainerRegistry/registries/rangersdockeracr"
}

# To allow for the web app restart
resource "azurerm_role_assignment" "dev_webapp_rbac" {
  principal_id         = "d0d5257b-bb1a-4272-b552-98a508458f5f" # Federated identity object ID
  role_definition_name = "Contributor"
  scope                = "/subscriptions/91c0fe80-4528-4bf2-9796-5d0f2a250518/resourceGroups/rg-rangers-dev"
}





