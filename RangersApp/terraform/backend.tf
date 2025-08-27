terraform {
  backend "azurerm" {
    resource_group_name  = "rg-rangers-app"
    storage_account_name = "tfstatebackend"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}