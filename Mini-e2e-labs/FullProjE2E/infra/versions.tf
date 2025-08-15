
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
  required_version = ">= 1.5.0" # Use a recent stable version
}

provider "azurerm" {
  features {} # This block is required, even if empty
  subscription_id = var.subscription_id # Updated Terrafrom Versions requirement 
}