variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "test-resource-group"
}

variable "location" {
  description = "Azure location for resources"
  type        = string
  default     = "East US"
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "test-vnet"
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
  default     = "test-subnet"
}

variable "subnet_prefix" {
  description = "Address prefix for the Subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "public_ip_name" {
  description = "Name of the public IP address"
  type        = string
  default     = "test-public-ip"
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
  default     = "test-nsg"
}

variable "nic_name" {
  description = "Name of the Network Interface"
  type        = string
  default     = "test-nic"
}

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
  default     = "test-vm"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "admin-bilal"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  default     = "Admin@1234"
}

