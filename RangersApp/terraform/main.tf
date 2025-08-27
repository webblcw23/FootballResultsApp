# RangersApp Terraform Configuration

# Provider Configuration

provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

}

#terraform block

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.75.0"
    }
  }

  required_version = ">= 1.3.0"
}


# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
   location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "rangersappstorageacct"
  resource_group_name      = "rg-rangers-app"
  location                 = "uksouth"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "rangersappstatecontainer"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

# Azure container registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
   location            = var.location
  sku                 = "Basic"
   admin_enabled       = true
}

# Azure Service Plan
resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
    sku_name = "B1" 
    os_type = "Linux"
  }

# Azure Linux Web App

resource "azurerm_linux_web_app" "app" {
  name                = "rangers-webapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      docker_image_name        = "rangersapp:v1"  # Just the repo + tag
      docker_registry_url      = "https://${azurerm_container_registry.acr.login_server}"
      docker_registry_username = azurerm_container_registry.acr.admin_username
      docker_registry_password = azurerm_container_registry.acr.admin_password
    }
  }

  app_settings = {
    "WEBSITES_PORT" = "80"
  }
}


output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

