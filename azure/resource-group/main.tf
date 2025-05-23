# Specify the provider and Azure configuration
provider "azurerm" {
  features {}
  subscription_id = "b48787a1-7145-425f-99af-62cde6c50e31"
}

# Generate a random suffix
resource "random_string" "suffix" {
  length  = 12
  special = false
  upper   = false
}

# Define the resource group
resource "azurerm_resource_group" "example" {
  name     = "exampleresourcegroup${random_string.suffix.result}"
  location = "EastUS"
}

# Define the storage account
resource "azurerm_storage_account" "example" {
  name                     = "exa${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "free-tier"
  }
}
