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
  subscription_id = "d751ecfe-8171-4f88-9aff-69aebef4cfc2"
  client_id       = "cca22cd1-4860-4be8-b2f4-d6fc417df344"
  client_secret   = "4uT7Q~u_cR0.yf9xJIsDs_8dkE3FlAPZet2OU"
  tenant_id       = "42f7676c-f455-423c-82f6-dc2d99791af7"

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
  address_prefixes = [ "10.0.0.0/24" ] 
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
    admin_username = "emroot"
    admin_password = "EmRoot123"

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


