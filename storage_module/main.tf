
resource "azurerm_resource_group" "storage_rg" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.all_tags

}

resource "azurerm_storage_account" "main" {
  name                      = var.name
  resource_group_name       = azurerm_resource_group.storage_rg.name
  location                  = var.location
  account_tier              = var.account_tier
  account_kind              = var.account_kind
  account_replication_type  = var.replication_type
  access_tier               = var.account_kind != "Storage" ? var.access_tier : null # Access tiers are only available for GPv2 accounts
  enable_https_traffic_only = var.enable_https_traffic_only
  is_hns_enabled            = var.account_tier == "Standard" ? var.is_hns_enabled : null
  min_tls_version           = var.min_tls_version
  tags                      = local.all_tags
}

resource "azurerm_storage_account_network_rules" "main" {
  storage_account_id         = azurerm_storage_account.main.id
  default_action             = var.network_deafult_rule
  ip_rules                   = var.network_ip_rules
  virtual_network_subnet_ids = var.network_subnet_ids

}

/*File share creation*/

resource "azurerm_storage_share" "fileshare" {
  count                = length(var.file_shares)
  name                 = var.file_shares[count.index].name
  storage_account_name = azurerm_storage_account.main.name
  quota                = var.file_shares[count.index].quota
}

/*Container creaton*/

resource "azurerm_storage_container" "container" {
  count                 = length(var.containers_list)
  name                  = var.containers_list[count.index].name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = var.containers_list[count.index].access_type
}

/*Table creation*/
resource "azurerm_storage_table" "tables" {
  count                = length(var.tables)
  name                 = var.tables[count.index]
  storage_account_name = azurerm_storage_account.main.name
}

/*Queue creation*/

resource "azurerm_storage_queue" "queues" {
  count                = length(var.queues)
  name                 = var.queues[count.index]
  storage_account_name = azurerm_storage_account.main.name
}
