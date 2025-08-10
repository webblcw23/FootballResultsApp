resource "azurerm_storage_account" "funcsa" {
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  tags                            = var.tags
}

resource "azurerm_service_plan" "plan" {
  name                = "${var.name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1" # Consumption
  tags                = var.tags
}

resource "azurerm_application_insights" "ai" {
  name                = "${var.name}-ai"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  # Removed invalid attribute
  tags = var.tags
}

resource "azurerm_linux_function_app" "func" {
  name                        = var.name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  service_plan_id             = azurerm_service_plan.plan.id
  storage_account_name        = azurerm_storage_account.funcsa.name
  storage_account_access_key  = azurerm_storage_account.funcsa.primary_access_key
  functions_extension_version = "~4"

  identity { type = "SystemAssigned" }

  app_settings = {
    "AzureWebJobsFeatureFlags"              = "EnableWorkerIndexing"
    "FUNCTIONS_WORKER_RUNTIME"              = "dotnet-isolated"
    "WEBSITE_RUN_FROM_PACKAGE"              = "1"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.ai.connection_string

    # App-specific (set via Key Vault reference in env layer)
    "SPORTS_API_BASE" = var.sports_api_base
    "RESULTS_PATH"    = var.results_path
    "FIXTURES_PATH"   = var.fixtures_path
    # "SPORTS_API_KEY" will be provided via Key Vault reference
    "TEAM_ID" = var.team_id
  }

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
    use_32_bit_worker   = false
    app_scale_limit     = 0 # allow dynamic scaling
    minimum_tls_version = "1.2"
    cors {
      allowed_origins = var.allowed_origins
    }
  }

  tags = var.tags
}

output "id" { value = azurerm_linux_function_app.func.id }
output "name" { value = azurerm_linux_function_app.func.name }
output "principal_id" { value = azurerm_linux_function_app.func.identity[0].principal_id }
output "default_hostname" { value = azurerm_linux_function_app.func.default_hostname }
