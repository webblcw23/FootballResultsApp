# RangersApp Terraform Configuration

# Provider Configuration

provider "azurerm" {
  features {}
  subscription_id = "91c0fe80-4528-4bf2-9796-5d0f2a250518"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
   location = var.location
}

# Azure container registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
   location            = var.location
  sku                 = "Basic"
   admin_enabled       = true
}

# Azure Service Plan
resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
    sku_name = "B1" 
    os_type = "Linux"
  }

# Azure Linux Web App
resource "azurerm_linux_web_app" "app" {
  name                = "rangersapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/rangersapp:latest"
  }

  app_settings = {
    "WEBSITES_PORT" = "80"
  }

  identity {
    type = "SystemAssigned"
  }
}



