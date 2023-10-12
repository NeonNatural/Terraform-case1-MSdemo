module "case_1_appservice" {
  source                = "./storage_module"
  app_service_plan_name = "${var.zone_name}${var.environment}appsp"
  resource_group_name   = "rg-appsp-${var.zone_name}-${var.environment}-${local.location_short}-001"
  location              = "westeurope"
  sku_name              = "P1v2"
  os_type               = "Windows"

  # App service 
  app_service_name          = "${var.zone_name}${var.environment}case1app"
  virtual_network_subnet_id = [module.spoke.subnet_ids["appservice_subnet"]]
}