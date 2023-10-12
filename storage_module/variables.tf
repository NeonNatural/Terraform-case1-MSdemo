variable "name" {
  description = "Storage account name"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name this storage account will be created in"
  default     = ""
}

variable "location" {
  description = "Azure region to use"
  type        = string
  default     = "westeurope"
}


variable "account_kind" {
  type        = string
  default     = "Storage"
  description = <<EOF
  "Defines the Kind of account.
  Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2.
  Changing this forces a new resource to be created. Defaults to Storage."
  EOF
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  type        = string
  default     = "GZRS"
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS."
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot"
  type        = string
  default     = "Hot"
}

variable "enable_https_traffic_only" {
  description = "Boolean flag which forces HTTPS if enabled"
  type        = bool
  default     = true
}

variable "is_hns_enabled" {
  type        = bool
  default     = false
  description = " Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account/). Changing this forces a new resource to be created."
}

variable "storage_account_tags" {
  type        = map(any)
  description = "The tags to be applied to this resource"
  default     = {}
}

variable "identity_type" {
  type        = string
  default     = ""
  description = "Specifies the identity type of the Data Factory. At this time the only allowed value is SystemAssigned."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2"
}

variable "file_shares" {
  description = "List of containers to create and their access levels."
  type        = list(object({ name = string, quota = number }))
  default     = []
}

variable "containers_list" {
  description = "List of containers to create and their access levels."
  type        = list(object({ name = string, access_type = string }))
  default     = []
}

variable "tables" {
  description = "List of storage tables."
  type        = list(string)
  default     = []
}

variable "queues" {
  description = "List of storages queues"
  type        = list(string)
  default     = []
}

variable "network_deafult_rule" {
  description = "This determines wether to allow traffic from all networks or selected netwrosk. Valid options are Deny or Allow"
  type        = string
  default     = "Deny"
}

variable "network_ip_rules" {
  description = "This is a list of specfic IP addresses to allow through the storage account firewall"
  type        = list(any)
  default     = []
}

variable "network_subnet_ids" {
  description = "This is the subnet/vnet to allow network traffic from, requires a subnet ID"
  type        = list(any)
  default     = []
}



variable "app_name" {
  type        = string
  description = "The name of the application, workload, or service that the resource is a part of. Examples: navigator, emissions, sharepoint, hadoop. Used for resource tags."
}


variable "business_unit" {
  type        = string
  description = "The business unit these resources belong to. Used for resource tags."
}

variable "cost_center" {
  type        = string
  description = "The cost center for the resources. Used for resource tags."
}

variable "environment" {
  type        = string
  description = "The stage of the development lifecycle for the workload that the resource supports. Examples: dev, test, uat, prod. Used for resource tags and default naming conventions."
}


