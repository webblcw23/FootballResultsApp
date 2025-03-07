output "resource_group_name" {
  description = "Name of the Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "app_service_url" {
  description = "The URL of the App Service"
  value       = module.app_service.app_service_url
}
