resource "azurerm_service_plan" "app_service_plan" {
  name                = var.service_plan_name
  location            = tfvar.location
  resource_group_name = var.resource_group_name
  os_type  = var.os_type
  sku_name = var.sku_name
}

resource "azurerm_app_service" "app_service" {
  name                = var.app_service_name
  location            = tfvar.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_service_plan.app_service_plan.id
}

output "app_service_url" {
  value = azurerm_app_service.app_service.default_site_hostname
}
