#--------------------------------------------------------------------------
#  Create the hub and spoke vnets with their subnets configured.
#--------------------------------------------------------------------------

// Modules
module "hub" {
  create_network_watcher = true
  network_watcher_name   = "NetworkWatcher_westeurope"
  source                 = "./network_module"

  resource_group_name = "rg-hub-${var.environment}"
  vnet_name           = "vnet-hub-${var.environment}"

  address_space = ["192.168.0.0/20"] //192.168.0.0 - 192.168.15.255

  diag_logs_la_workspace_id          = module.mgmt_security.ops_log_analytics_workspace_id
  diag_logs_la_workspace_location    = module.mgmt_security.ops_log_analytics_location // location value needed for nsg flow log traffic analytics
  diag_logs_la_workspace_resource_id = module.mgmt_security.ops_log_analytics_workspace_resource_id
  environment                        = var.environment
  location                           = var.network_location
  location_short                     = var.network_location_short



  tags = { ResourceType = "Virtual Network", App = "Case-1", environment = "${var.environment}" }

  subnets = {

    demo_hub_subnet = {
      subnet_name           = "snet-demo-hub-${var.environment}-westeu-001"
      subnet_address_prefix = ["192.168.0.0/24"]
      nsg                   = false
    }

  }

  vnet_diag_object = {
    log = [
      # ["Category name",  "Diagnostics Enabled(true/false)", Retention_period(# of days)]
      ["VMProtectionAlerts", true, 30],
    ]
    metric = [
      #["Category name",  "Diagnostics Enabled(true/false)", Retention_period(# of days)]
      ["AllMetrics", true, 30]
    ]
  }
}


module "spoke" {
  depends_on = [
    module.hub
  ]



  source = "./network_module/network-module"

  resource_group_name = "rg-spoke-${var.environment}"

  vnet_name = "vnet-spoke-${var.environment}"

  address_space = ["192.168.16.0/20"] //192.168.16.0 - 192.168.31.255

  create_network_watcher = true
  network_watcher_name   = "NetworkWatcher_westeurope"
  environment            = var.environment

  location       = var.network_location
  location_short = var.network_location_short
  tags           = { ResourceType = "Virtual Network", App = "Case1", environment = "${var.environment}" }

  subnets = {

    appservice_subnet = {
      subnet_name           = "snet-spoke-appservice"
      subnet_address_prefix = ["192.168.18.0/24"]
      service_endpoints = [
        "Microsoft.AzureActiveDirectory",
        "Microsoft.KeyVault",
        "Microsoft.Sql",
        "Microsoft.Storage"
      ]
      nsg = true
      nsg_rules = [{
        name                       = "Case1_inboundnsgrule1"
        priority                   = "102"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_ranges    = [443]
        source_address_prefix      = "192.168.1.0/24"
        destination_address_prefix = "*"
        },
        {
          name                       = "Case1_inboundnsgrule2"
          priority                   = "110"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_ranges    = [443]
          source_address_prefix      = "192.168.0.0/24"
          destination_address_prefix = "*"
      }]
    }

    storage_subnet = {
      subnet_name                                    = "snet-spoke-storage"
      subnet_address_prefix                          = ["192.168.19.0/24"]
      enforce_private_link_endpoint_network_policies = true
      service_endpoints = [
        "Microsoft.AzureActiveDirectory",
        "Microsoft.KeyVault",
        "Microsoft.Sql",
        "Microsoft.Storage"
      ]
    }

  }

  vnet_diag_object = {
    log = [
      # ["Category name",  "Diagnostics Enabled(true/false)", Retention_period(# of days)]
      ["VMProtectionAlerts", true, 30],
    ]
    metric = [
      #["Category name",  "Diagnostics Enabled(true/false)", Retention_period(# of days)]
      ["AllMetrics", true, 30]
    ]
  }

}

# Create peering between the above vnets
resource "azurerm_virtual_network_peering" "peering_hub_spoke" {
  name                      = "peering_hub_spoke"
  resource_group_name       = module.hub.rg_name
  virtual_network_name      = module.hub.vnet_name
  remote_virtual_network_id = module.spoke.vnet_id
}
resource "azurerm_virtual_network_peering" "peering_spoke_hub" {
  name                      = "peering_spoke_hub"
  resource_group_name       = module.spoke.rg_name
  virtual_network_name      = module.spoke.vnet_name
  remote_virtual_network_id = module.hub.vnet_id
}

