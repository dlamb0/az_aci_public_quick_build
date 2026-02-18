terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Local state - file will be created in this directory as terraform.tfstate
  backend "local" {}
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}