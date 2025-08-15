#location variable {
variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
}  

# resource_group_name variable {
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string        
}

variable "source_content" {
  description = "The content of the index.html file."
  type        = string
}

variable "azurerm_storage_blob_name" {
  description = "The name of the storage blob."
  type        = string
}

variable "index_document" {
  description = "The index document for the static website."
  type        = string  
}