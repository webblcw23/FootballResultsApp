# Provider is in provider.terraform 

# Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name     = "terraformytproj"
  location = var.location
}

# Create a storage account free tier
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
}

resource "azurerm_storage_account_static_website" "static_website" {
  storage_account_id = azurerm_storage_account.storage_account.id
  index_document     = var.index_document
}

# Add an index.html file
resource "azurerm_storage_blob" "blob" {
  name                   = var.azurerm_storage_blob_name
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_account_static_website.static_website.container_name
  #storage_container_name = "$web" # This is the default container name for static websites
  type                   = "Block"
    content_type          = "text/html"  
    source_content = var.source_content
}

##########################
