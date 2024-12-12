resource_group_name        = "test-resource-group"
location                   = "East US"
vnet_name                  = "test-vnet"
address_space              = ["10.0.0.0/16"]
subnet_name                = "test-subnet"
subnet_prefix              = ["10.0.1.0/24"]
nic_name                   = "test-nic"
vm_name                    = "test-vm"
vm_size                    = "Standard_B1s"
admin_username             = "admin-bilal"
admin_password             = "Admin@1234"
state_storage_account_name = "statestorageacctbilal"
state_container_name       = "tfstate"
state_file_name            = "terraform.tfstate"
