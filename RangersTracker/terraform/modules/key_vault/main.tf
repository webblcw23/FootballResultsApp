resource "azurerm_key_vault" "kv" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  soft_delete_retention_days    = 7
  purge_protection_enabled      = false
  enable_rbac_authorization     = true
  public_network_access_enabled = true
  tags                          = var.tags
}

output "id" { value = azurerm_key_vault.kv.id }
output "name" { value = azurerm_key_vault.kv.name }
