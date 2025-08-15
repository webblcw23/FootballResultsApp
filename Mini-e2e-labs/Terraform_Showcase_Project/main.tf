// conect to Azure
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

// create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "app_service" {
  source              = "./modules/app_service"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  app_service_name    = var.app_service_name
  service_plan_name   = var.service_plan_name
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "app_service_url" {
  value = module.app_service.app_service_url
}
