# RangersApp Terraform Configuration

# Provider Configuration

provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# Resource Group
data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
# location = var.location
}

# Azure container registry
data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Azure Service Plan
resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
    sku_name = "B1" 
    os_type = "Linux"
  }

# Azure Linux Web App
resource "azurerm_linux_web_app" "app" {
  name                = "rangersapp"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
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


