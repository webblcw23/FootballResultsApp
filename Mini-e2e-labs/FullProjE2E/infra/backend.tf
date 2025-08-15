terraform {
  backend "azurerm" {
    resource_group_name  = "rg-thefullproj"
    storage_account_name = "tfstatelewis"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

#cannot use variables here for the backend. Needs to be hardcoded 