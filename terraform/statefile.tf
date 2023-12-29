terraform {
  backend "azurerm" {
    resource_group_name   = "rg-statefile"
    storage_account_name  = "storagestatefile"
    container_name        = "sa-container"
    key                   = "terraform.tfstate"
  }
}