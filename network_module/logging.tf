// VNET Diagnostic Logging

resource "azurerm_monitor_diagnostic_setting" "vnet_diag_logs" {
  name               = "log-diag-${azurerm_virtual_network.vnet.name}"
  target_resource_id = azurerm_virtual_network.vnet.id

  storage_account_id         = var.diag_logs_storage_account_id != "" ? var.diag_logs_storage_account_id : null
  log_analytics_workspace_id = var.diag_logs_la_workspace_resource_id


  dynamic "log" {
    for_each = var.vnet_diag_object.log

    content {
      category = log.value[0]
      enabled  = log.value[1]

      retention_policy {
        enabled = log.value[2] != null ? true : false
        days    = log.value[2]
      }
    }
  }

  dynamic "metric" {
    for_each = var.vnet_diag_object.metric

    content {
      category = metric.value[0]
      enabled  = metric.value[1]

      retention_policy {
        enabled = metric.value[2] != null ? true : false
        days    = metric.value[2]
      }
    }
  }
}



