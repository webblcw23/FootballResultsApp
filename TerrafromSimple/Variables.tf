variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
}

variable "location" {
    description = "The location of the resource group"
    type        = string
    default     = "East US"
}

variable "storage_account_name" {
    description = "The name of the storage account"
    type        = string
}

variable "storage_account_tier" {
    description = "The tier of the storage account"
    type        = string
    default     = "Standard"
}

variable "storage_account_replication_type" {
    description = "The replication type of the storage account"
    type        = string
    default     = "LRS"
}

variable "loginDetails" {
    description = "The login details for the virtual machine"
    type        = object({
        username = string
        password = string
    })
    default = {
        username = "adminuser"
        password = "Password1234!"
    }
}