module "app_service_storage" {
  source                    = "./storage_module"
  name                      = "${var.zone_name}${var.environment}storagcase1"
  resource_group_name       = "rg-sta-${var.zone_name}-${var.environment}-${local.location_short}-001"
  replication_type          = "GZRS"
  account_kind              = "StorageV2"
  access_tier               = "Hot"
  location                  = "westeurope"
  environment               = var.environment
  enable_https_traffic_only = true
  identity_type             = "SystemAssigned"

  #network config
  network_deafult_rule = "Deny"
  network_subnet_ids   = [module.spoke.subnet_ids["storage_subnet"]]



  #file shares
  file_shares = [
    { name = "case1_file1", quota = 500 },
    { name = "case1_file2", quota = 3000 }
  ]

  #container 
  containers_list = [
    { name = "blobstorecase1", access_type = "private" }
  ]

  storage_account_tags = { ResourceType = "Storage account", App = "Case1_app" }
  app_name             = "Case1_app"
  cost_center          = "Mastercard_Dublin"


}