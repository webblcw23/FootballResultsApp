// connect to Azure
provider "azurerm" {
  features {}
  subscription_id = "91c0fe80-4528-4bf2-9796-5d0f2a250518"
}

// create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "devops-terraform-rg"
  location = "westeurope"
}

// create an app service plan - free tier
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "devops-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

// create an app service - web app
resource "azurerm_app_service" "app_service" {
  name                = "devops-web-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}
