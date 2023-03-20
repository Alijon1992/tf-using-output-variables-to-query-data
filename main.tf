



# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

#create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "deoprg"
  location = "canadacentral"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "deopvnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

#create subnet

resource "azurerm_subnet" "subnet" {
  name                 = "deopsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}