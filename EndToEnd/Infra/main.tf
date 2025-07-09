# Connect to Azure Provider 
provider "azurerm" {
  features {}
  subscription_id = "91c0fe80-4528-4bf2-9796-5d0f2a250518"
}

# Used here to get the current Azure client configuration, such as tenant ID and object ID.
data "azurerm_client_config" "current" {}


# Create Resoruce Group

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create an app Service Plan 

resource "azurerm_app_service_plan" "plan" {
  name                = "${var.prefix}-app-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

# Create an App Service (Web app) in the App Service Plan

resource "azurerm_app_service" "webapp" {
  name                = "${var.prefix}-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
}
