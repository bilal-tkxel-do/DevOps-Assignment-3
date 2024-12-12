# Resource Variables
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

variable "state_resource_group_name" {
  description = "The name of the resource group for storage account"
  type        = string
  default     = "teststaterg"
}

variable "state_storage_account_name" {
  description = "The name of the storage account for Terraform state"
  type        = string
  default     = "teststorageaccount"
}

variable "state_container_name" {
  description = "The name of the blob container for Terraform state"
  type        = string
  default     = "terraform-state"
}

variable "state_file_name" {
  description = "The name of the Terraform state file"
  type        = string
  default     = "terraform.tfstate"
}
