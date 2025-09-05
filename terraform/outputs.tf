
output "dev_webapp_name" {
  value = azurerm_linux_web_app.dev.name
}

output "staging_webapp_name" {
  value = azurerm_linux_web_app.staging.name
}

output "prod_webapp_name" {
  value = azurerm_linux_web_app.prod.name
}

output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "football_api_key_secret_id" {
  value     = azurerm_key_vault_secret.football_api_key.id
  sensitive = true # Marking as sensitive to avoid accidental exposure depsite the mock value. Good practice.
}
