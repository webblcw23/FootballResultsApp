output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "app_service_url" {
  description = "URL of the App Service"
  value       = azurerm_app_service.app_service.default_site_hostname
}
