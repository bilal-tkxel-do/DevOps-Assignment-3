# Required providers
terraform {
  backend "azurerm" {
    resource_group_name  = "state-resource-group"
    storage_account_name = "statestorageacctbilal"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.3.0"
}

# Azure Provider Configuration with Authentication
provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "test_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "test_vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
}

# Subnet
resource "azurerm_subnet" "test_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.test_rg.name
  virtual_network_name = azurerm_virtual_network.test_vnet.name
  address_prefixes     = var.subnet_prefix
}

# Network Interface
resource "azurerm_network_interface" "test_nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "test_vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.test_rg.name
  location            = azurerm_resource_group.test_rg.location
  size                = var.vm_size

  admin_username = var.admin_username
  admin_password = var.admin_password

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.test_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
