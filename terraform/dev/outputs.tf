
output "dev_webapp_name" {
  value = azurerm_linux_web_app.rangers_webapp_dev.name
}

output "webapp_url" {
  value = "https://${azurerm_linux_web_app.rangers_webapp_dev.default_hostname}"
}


output "identity_principal_id" {
  value = azurerm_linux_web_app.rangers_webapp_dev.identity[0].principal_id
}



