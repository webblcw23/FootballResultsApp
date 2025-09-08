provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

}


resource "azurerm_resource_group" "rangers_rg_core" {
  name     = "rg-rangers-core"
  location = "UK South"
}

resource "azurerm_container_registry" "rangers_acr" {
  name                = "rangersdockeracr"
  resource_group_name = azurerm_resource_group.rangers_rg_core.name
  location            = azurerm_resource_group.rangers_rg_core.location
  sku                 = "Basic"
  admin_enabled       = false
  tags = {
    env     = "core"
    project = "rangersapp"
  }
}




## Remember to push the docker image to ACR after building it locally
## az acr login --name rangersdockeracr
## docker tag rangersapp:latest rangersdockeracr.azurecr.io/rangersapp:v1
## docker push rangersdockeracr.azurecr.io/rangersapp:v1


# Optional: Shared Key Vault
# resource "azurerm_key_vault" "rangers_kv" {
#   name                        = "rangerscorekv"
#   location                    = azurerm_resource_group.core_rg.location
#   resource_group_name         = azurerm_resource_group.core_rg.name
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   sku_name                    = "standard"
#   soft_delete_enabled         = true
#   purge_protection_enabled    = false
# }

# Optional: DNS Zone, App Insights, etc. could go here too.
