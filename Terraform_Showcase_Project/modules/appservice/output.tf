output "app_service_url" {
  description = "The default hostname of the App Service"
  value       = azurerm_app_service.app_service.default_site_hostname
}
