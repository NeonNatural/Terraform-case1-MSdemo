output "storage_account" {
  value       = azurerm_storage_account.main
  description = "All Storage account attributes"
}

output "id" {
  value       = azurerm_storage_account.main.id
  description = "Storage account generated id"
}

output "name" {
  value       = azurerm_storage_account.main.name
  description = "Storage account name"
}

output "location" {
  value       = azurerm_storage_account.main.location
  description = "Storage account location"
}

# File

output "primary_file_endpoint" {
  value       = azurerm_storage_account.main.primary_file_endpoint
  description = "The endpoint URL for file storage in the primary location."
}

output "primary_file_host" {
  value       = azurerm_storage_account.main.primary_file_host
  description = "The hostname with port if applicable for file storage in the primary location."
}

output "secondary_file_endpoint" {
  value       = azurerm_storage_account.main.secondary_file_endpoint
  description = " The endpoint URL for file storage in the secondary location."
}

output "secondary_file_host" {
  value       = azurerm_storage_account.main.secondary_file_host
  description = "The hostname with port if applicable for file storage in the secondary location."
}

# Access keys

output "primary_access_key" {
  value       = azurerm_storage_account.main.primary_access_key
  description = "The primary access key for the storage account."
}

output "secondary_access_key" {
  value       = azurerm_storage_account.main.secondary_access_key
  description = "The secondary access key for the storage account."
}

# Connection strings

output "primary_connection_string" {
  value       = azurerm_storage_account.main.primary_connection_string
  description = "The connection string associated with the primary location."
}

output "secondary_connection_string" {
  value       = azurerm_storage_account.main.secondary_connection_string
  description = "The connection string associated with the secondary location."
}
