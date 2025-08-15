# Output variables for the Azure resources created in the Terraform configuration

output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "webapp_url" {
  value       = azurerm_app_service.webapp.default_site_hostname
  description = "Default URL for the deployed App Service"
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}
