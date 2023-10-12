resource "azurerm_resource_group" "rsg" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.all_tags
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.rsg.name
  location            = azurerm_resource_group.rsg.location
  sku_name            = var.sku_name
  os_type             = var.os_type
}

resource "azurerm_windows_web_app" "web_app" {
  name                      = var.app_service_name
  resource_group_name       = azurerm_resource_group.rsg.name
  location                  = azurerm_service_plan.app_service_plan.location
  service_plan_id           = azurerm_service_plan.app_service_plan.id
  virtual_network_subnet_id = var.virtual_network_subnet_id

  site_config {
    always_on = var.always_on

  }
}