terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.59.0"
    }
  }
  required_version = ">= 0.15"
}

provider "azurerm" {
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""

  features {

  }
}

#creates resource group 
resource "azurerm_resource_group" "main" {
  name     = "learn-tf-rg-westeurope"
  location = "westeurope"
}

#Creates virtual network 
resource "azurerm_virtual_network" "main" {
  name = "learn-tf-vnet-westeurope"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space = ["10.0.0.0/16"]
}

#Create subnet 
resource "azurerm_subnet" "main" {
  name = "learn-tf-subnet-westeurope"
  virtual_network_name = azurerm_virtual_network.main.name 
  resource_group_name = azurerm_resource_group.main.name
  address_prefixes = [ "" ] 
}

#Creates network interface card (NIC)
resource "azurerm_network_interface" "internal" {
    name = "learn-tf-nic-int-westeurope"
    location = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    ip_configuration {
      name = "internal"
      subnet_id = azurerm_subnet.main.id
      private_ip_address_allocation = "Dynamic"
    }
}

#Creates Virtual Machine 
resource "azurerm_windows_virtual_machine" "name" {
    name = "learn-tf-vm"
    resource_group_name = azurerm_resource_group.main.name
    location = azurerm_resource_group.main.location
    size = "Standard_B1s"
    admin_username = ""
    admin_password = "E"

    network_interface_ids = [ 
        azurerm_network_interface.internal.id 
     ]

    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "MicrosoftwindowsServer"
      offer = "WindowsServer"
      sku = "2016-DataCenter"
      version = "latest"
    }
}


