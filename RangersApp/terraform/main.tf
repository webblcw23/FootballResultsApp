# Connect to Azure
provider "azurerm" {
  subscription_id = "91c0fe80-4528-4bf2-9796-5d0f2a250518"
  features {}
}

# Creation of Azure resources for Rangers App
resource "azurerm_resource_group" "rangers" {
  name     = "rg-rangers-app"
  location = "UK South"
}

# Creation of Azure resources for Rangers App Service Plan and Web App
resource "azurerm_service_plan" "rangers_plan" {
  name                = "asp-rangers"
  location            = azurerm_resource_group.rangers.location
  resource_group_name = azurerm_resource_group.rangers.name
  sku_name            = "F1"
  os_type             = "Linux"
}

# Creation of Azure resources for Rangers App Service
resource "azurerm_linux_web_app" "rangers_web" {
  name                = "rangers-app"
  location            = azurerm_resource_group.rangers.location
  resource_group_name = azurerm_resource_group.rangers.name
  service_plan_id     = azurerm_service_plan.rangers_plan.id
  site_config {
    linux_fx_version = "DOCKER|rangersacr.azurecr.io/rangersapp:latest"
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://rangersacr.azurecr.io"
    "DOCKER_REGISTRY_SERVER_USERNAME" = "rangersacr"
    "DOCKER_REGISTRY_SERVER_PASSWORD" = "your_password_here" # Replace with your actual password
  }

}
