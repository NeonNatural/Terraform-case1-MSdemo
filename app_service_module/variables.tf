variable "resource_group_name" {
  type        = string
  description = "The resource group name this App service plan and App service will be created in"
  default     = ""
}

variable "location" {
  description = "Azure region to use"
  type        = string
  default     = "westeurope"
}

variable "app_service_plan_name" {
  description = "App service plan name"
  type        = string
}

variable "app_service_name" {
  description = "App service name"
  type        = string
}

variable "sku_name" {
  description = "App service plan SKU"
  type        = string
}

variable "os_type" {
  description = "App service plan OS type"
  type        = string
}

variable "virtual_network_subnet_id" {
  description = "The subnet id which will be used by this Web App for regional virtual network integration."
  type        = string
}

variable "always_on" {
  description = "If this Windows Web App is Always On enabled. Defaults to true"
  default     = true
  type        = string
}
