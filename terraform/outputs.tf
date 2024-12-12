output "vm_private_ip" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.test_nic.ip_configuration[0].private_ip_address
}

output "resource_group_name" {
  description = "Name of the Resource Group"
  value       = azurerm_resource_group.test_rg.name
}

