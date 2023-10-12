output "id" {
  value       = azurerm_windows_web_app.web_app.id
  description = "The ID of the Windows Web App."
}

output "default_hostname" {
  value       = azurerm_windows_web_app.web_app.default_hostname
  description = "The default hostname of the Windows Web App."
}
