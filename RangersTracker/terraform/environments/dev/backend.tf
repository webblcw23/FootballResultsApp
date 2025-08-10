terraform {
  backend "azurerm" {
    resource_group_name  = "FootballScoresRG"
    storage_account_name = "REPLACE_STATE_STORAGE"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
