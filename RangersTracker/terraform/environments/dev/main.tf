terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.113"
    }
  }
}
provider "azurerm" {
  features {}
}

locals {
  rg_name = "rg-rangers-tracker"
  name    = "rtk-dev-func"
  static  = "strtkfrontend"
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

# Key Vault
module "kv" {
  source              = "../../modules/key_vault"
  name                = "kv-rangers-tracker"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tenant_id           = var.tenant_id
  tags                = var.tags
}

# Function App (serverless API)
module "func" {
  source               = "../../modules/function_app"
  name                 = local.name
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  storage_account_name = "st${local.name}code" # must be globally unique; adjust in tfvars or variables if needed
  tags                 = var.tags

  # Optional: configure provider endpoints if you choose one later
  sports_api_base = ""
  results_path    = ""
  fixtures_path   = ""
  team_id         = "rangers"
  allowed_origins = ["*"]
}

# Grant Function managed identity permission to read secrets
resource "azurerm_role_assignment" "kv_secrets_user" {
  scope                = module.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.func.principal_id
}

# Static website for frontend (cheap + fast)
resource "azurerm_storage_account" "static" {
  name                            = local.static
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = true
  tags                            = var.tags
}

resource "azurerm_storage_account_static_website" "site" {
  storage_account_id = azurerm_storage_account.static.id
  index_document     = "index.html"
  error_404_document = "index.html"
}

output "frontend_url" {
  value = "https://${azurerm_storage_account.static.name}.z6.web.core.windows.net"
}

output "api_url" {
  value = "https://${module.func.default_hostname}/api"
}
