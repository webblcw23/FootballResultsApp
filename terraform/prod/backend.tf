terraform {
  backend "azurerm" {
    resource_group_name  = "rg-rangers-core"
    storage_account_name = "rangersstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
