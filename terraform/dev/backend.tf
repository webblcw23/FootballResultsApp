#terraform {
#  backend "azurerm" {
#    resource_group_name   = "rg-rangers-dev"
#    storage_account_name  = "rangersappstorageacct"
#    container_name        = "rangersappstatecontainer"
#    key                   = "terraform.tfstate"
#  }
#}