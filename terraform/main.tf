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

resource "azurerm_public_ip" "test_public_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name

  allocation_method = "Dynamic"
  sku               = "Basic"
}

resource "azurerm_network_security_group" "test_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  resource_group_name         = azurerm_resource_group.test_rg.name
  name                        = "allow_ssh"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.test_nsg.name
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
    public_ip_address_id          = azurerm_public_ip.test_public_ip.id
  }

}

# Network Interface Security Group Association
resource "azurerm_network_interface_security_group_association" "test_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.test_nic.id
  network_security_group_id = azurerm_network_security_group.test_nsg.id
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
