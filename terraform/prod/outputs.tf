
output "prod_webapp_name" {
  value = azurerm_linux_web_app.rangers_webapp_prod.name
}

output "webapp_url" {
  value = "https://${azurerm_linux_web_app.rangers_webapp_prod.default_hostname}"
}


output "identity_principal_id" {
  value = azurerm_linux_web_app.rangers_webapp_prod.identity[0].principal_id
}



