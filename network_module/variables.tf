// Common

variable "environment" {
  type        = string
  description = "The stage of the development lifecycle for the workload that the resource supports. Examples: dev, test, uat, prod."
}

variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist in full format. Examples: eastus2, westeurope, southeastasia. Changing this forces a new Resource Group to be created."
}

variable "location_short" {
  type        = string
  description = "The Azure Region where the Resource Group should exist, abbreviated. Examples: eus2, weu, sea. For standard abbreviations, see <insert link>. Changing this forces a new Resource Group to be created."
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the Resource Group resources will be deployed into. If no value is specified, one will be provided."
}

variable "app_name" {
  type        = string
  description = "The name of the application, workload, or service that the resource is a part of. Examples: navigator, emissions, sharepoint, hadoop."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags which should be assigned to all resources (except the Firewall Policy. See `policy_tags`.)."
}

variable "policy_tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags which should be assigned to the Firewall Policy. The key of policy tags must be lowercase due to a bug in the Azure API: https://github.com/terraform-providers/terraform-provider-azurerm/issues/9620"
}

variable "diag_logs_la_workspace_id" {
  type        = string
  description = "The Workspace ID of the Log Analytics Workspace where diagnostics logs and NSG flow logs should be sent."
}

variable "diag_logs_la_workspace_location" {
  type        = string
  description = "The Azure region of the Log Analytics Workspace where diagnostics logs and NSG flow logs should be sent."
}

variable "diag_logs_la_workspace_resource_id" {
  type        = string
  description = "The ID of the Log Analytics Workspace where diagnostics logs and NSG flow logs should be sent."
}


// Virtual Network

variable "vnet_name" {
  type        = string
  default     = ""
  description = "The name of the Virtual Network. If no value is specified, one will be provided."
}

variable "create_network_watcher" {
  type        = bool
  default     = true
  description = "Wether to create a Network Watcher and Resource Group. For scenarios where multiple Virtual Networks are deployed to the same region, set this value to false on all module calls except the first one that initially creates the Network Watcher. Defaults to true."
}

variable "network_watcher_name" {
  type        = string
  default     = ""
  description = "The name of the Network Watcher. If no value is specified, one will be provided using the Azure default naming convention: `NetworkWatcher_<region>`."
}

variable "existing_network_watcher_rg_name" {
  type        = string
  default     = ""
  description = "The name of the Resource Group containing the existing Network Watcher. For scenarios where multiple Virtual Networks are deployed to the same region, specify this variable with the name from the first module call that initially creates the Network Watcher for the region and set variable `create_network_watcher` to false."
}

variable "existing_network_watcher_name" {
  type        = string
  default     = ""
  description = "The name of the existing Network Watcher. For scenarios where multiple Virtual Networks are deployed to the same region, specify this variable with the name from the first module call that initially creates the Network Watcher for the region and set variable `create_network_watcher` to false."
}

variable "address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "Address space of the Virtual Network. Defaults to 10.0.0.0/16."
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "DNS servers to be used with Virtual Network. If none specified, defaults to Azure DNS."
}




variable "subnets" {
  default     = {}
  description = "A mapping of subnet names in the Virtual Network. By default, subnets will be associated with a Network Security Group (NSG). To create a subnet without an NSG, specify `nsg = false`. Any rules specified for the NSG will be in addition to the default rules."
}

variable "subnet_service_endpoints" {
  type        = map(any)
  default     = {}
  description = "A mapping of subnet name to service endpoints to add to the subnet."
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  type        = map(bool)
  default     = {}
  description = "A mapping of subnet name to enable/disable private link endpoint network policies on the subnet."
}

variable "subnet_enforce_private_link_service_network_policies" {
  type        = map(bool)
  default     = {}
  description = "A mapping of subnet name to enable/disable private link service network policies on the subnet."
}



// Vnet Logging

variable "vnet_diag_object" {
  default = {
    log = [
      # ["Category name",  "Diagnostics Enabled(true/false)", Retention_period(# of days)]
      ["VMProtectionAlerts", true, 30],
    ]
    metric = [
      #["Category name",  "Diagnostics Enabled(true/false)", Retention_period(# of days)]
      ["AllMetrics", true, 30],
    ]
  }
  description = <<EOD
  Contains the diagnostics setting object. Defaults to all logs and metrics enabled with 30 days retention. Example:
  diag_object = {
    log = [
      # ["Category name",  "Diagnostics Enabled(true/false)", Retention_period(# of days)]
      ["VMProtectionAlerts", true, 30],
    ]
    metric = [
      #["Category name",  "Diagnostics Enabled(true/false)", Retention_period(# of days)]
      ["AllMetrics", true, 30]
    ]
  }
  EOD
}

variable "diag_logs_storage_account_id" {
  type        = string
  default     = ""
  description = "Specifies the ID of the Storage Account where Diagnostics Logs should be sent. By default, Diagnostics Logs are only sent to Azure Monitor via Log Analystics Workspace."
}

variable "eventhub_auth_rule_id" {
  type        = string
  default     = ""
  description = "The authorization rule ID of the Eventhub to send diagnostic logs to. By default, Diagnostics Logs are only sent to Azure Monitor via Log Analystics Workspace."
}

variable "eventhub_name" {
  type        = string
  default     = ""
  description = "The name of the Eventhub to send diagnostic logs to. By default, Diagnostics Logs are only sent to Azure Monitor via Log Analystics Workspace."
}
