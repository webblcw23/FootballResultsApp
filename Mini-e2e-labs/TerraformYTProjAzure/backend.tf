## These need to be deployed before the backend can be configured - via the CLI or portal
# Create the resource group
##### az group create --name terraformytproj --location eastus

# Create the storage account (must be globally unique and all lowercase)
#### az storage account create --name backendstorageacct --resource-group terraformytproj --location eastus --sku Standard_LRS

# Create the blob container for state files
#### az storage container create --name tfstate --account-name backendstorageacct

# Configure the backend for Terraform state management

terraform {
  backend "azurerm" {
    resource_group_name  = azurerm_resource_group.resource_group.name
    storage_account_name = azurerm_storage_account.backend_storage_account.name
    container_name       = azurerm_storage_container.backend_container.name
    key                  = "terraform.tfstate"  
    
  }
}