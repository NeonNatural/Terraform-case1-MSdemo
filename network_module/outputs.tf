// Common

output "rg_id" {
  value       = azurerm_resource_group.network_rg.id
  description = "The ID of the Resource Group."
}

output "rg_name" {
  value       = azurerm_resource_group.network_rg.name
  description = "The name of the Resource Group."
}

output "rg_location" {
  value       = azurerm_resource_group.network_rg.location
  description = "The location of the Resource Group."
}


// Virtual Network

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The ID of the vnet."
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "The name of the vnet."
}

output "vnet_address_space" {
  value       = azurerm_virtual_network.vnet.address_space
  description = "The address space of the vnet."
}


output "subnet_ids" {
  value = tomap({
    for s, subnet in azurerm_subnet.subnet : s => subnet.id
  })
  description = "The IDs of the subnets in the vnet."
}

output "subnet_names" {
  value = tomap({
    for s, subnet in azurerm_subnet.subnet : s => subnet.name
  })
  description = "The names of the subnets in the vnet."
}

output "subnet_address_prefixes" {
  value = tomap({
    for s, subnet in azurerm_subnet.subnet : s => subnet.address_prefixes
  })
  description = "The address prefixes of the subnets in the vnet."
}


