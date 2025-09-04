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

# Storage Account for Terraform State
resource "azurerm_storage_account" "tfstate" {
  name                     = "rangersappstorageacct"
  resource_group_name      = "rg-rangers-app"
  location                 = "uksouth"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Container for Terraform State
resource "azurerm_storage_container" "tfstate" {
  name                  = "rangersappstatecontainer"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

# Azure container registry
#resource "azurerm_container_registry" "acr" {
#  name                = var.acr_name
#  resource_group_name = azurerm_resource_group.rg.name
#  location            = azurerm_resource_group.rg.location
#  sku                 = "Basic"
#  admin_enabled       = true
#  admin_username      = "rangersacradmin"
#  admin_password      = var.acr_password
#}


# Azure Key Vault
resource "azurerm_key_vault" "kv" {
  name                     = "rangersapp-kv"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  tenant_id                = var.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = false

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.devops_sp_object_id # Azure DevOps service principal
    secret_permissions = [
      "get",
      "list"
    ]
  }
}

# Storing a mock API key in Key Vault as a secret to demonstrate Key Vault usage and knowledge
resource "azurerm_key_vault_secret" "football_api_key" {
  name         = "football-data-api-key"
  value        = "mock-api-key-123"
  key_vault_id = azurerm_key_vault.kv.id
}



# Azure Service Plan
resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "B1"
  os_type             = "Linux"
}


##### # Creating 3 separate envs for the web app - Dev, Test, Prod ######

# Azure Linux Web App - Dev
resource "azurerm_linux_web_app" "dev" {
  name                = "rangers-webapp-dev"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      docker_image_name   = "${var.image_name}:latest"
      docker_registry_url = "https://${azurerm_container_registry.acr.login_server}"
    }
  }

  app_settings = {
    "WEBSITES_PORT" = "80"
  }
}

# Azure Linux Web App - Staging
resource "azurerm_linux_web_app" "staging" {
  name                = "rangers-webapp-staging"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      docker_image_name   = "${var.image_name}:latest"
      docker_registry_url = "https://${azurerm_container_registry.acr.login_server}"
    }
  }

  app_settings = {
    "WEBSITES_PORT" = "80"
  }
}

# Azure Linux Web App - Prod
resource "azurerm_linux_web_app" "prod" {
  name                = "rangers-webapp-prod"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      docker_image_name   = "${var.image_name}:latest"
      docker_registry_url = "https://${azurerm_container_registry.acr.login_server}"
    }
  }

  app_settings = {
    "WEBSITES_PORT" = "80"
  }
}


#########


# Ensure the backend configuration is set up correctly before running Terraform commands
# Run the following Azure CLI commands to create the necessary resources for the backend:
# az group create --name rg-rangers-app --location uksouth
# az storage account create --name rangersappstorageacct --resource-group rg-rangers-app --sku Standard_LRS
# az storage container create --name tfstate --account-name rangersappstorageacct
