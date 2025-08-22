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
  sku_name            = "B1"
  os_type             = "Windows"
}

# Creation of Azure resources for Rangers App Service
resource "azurerm_windows_web_app" "rangers_web" {
  name                = "rangers-app"
  location            = azurerm_resource_group.rangers.location
  resource_group_name = azurerm_resource_group.rangers.name
  service_plan_id     = azurerm_service_plan.rangers_plan.id

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14.17"
    "RANGERS_API_URL"              = "https://api.rangersapp.com"
  }

  site_config {
    always_on = true
  }
}
