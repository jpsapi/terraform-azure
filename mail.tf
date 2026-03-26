terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # COMENTE ESTE BLOCO AGORA
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-state"
  #   storage_account_name = "sttfstatecorenmg"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}

# 1. Recurso do Resource Group
resource "azurerm_resource_group" "state-rg" {
  name     = "rg-terraform-state"
  location = "southcentralus"
}

# 2. Recurso do Storage Account
resource "azurerm_storage_account" "state-sa" {
  name                     = "sttfstatecorenmg"
  resource_group_name      = azurerm_resource_group.state-rg.name
  location                 = azurerm_resource_group.state-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# 3. Recurso do Container
resource "azurerm_storage_container" "state-container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.state-sa.name
  container_access_type = "private"
}