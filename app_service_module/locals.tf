locals {
  default_tags = {
    CreationDate = timestamp()
    DeployedBy   = "terraform"
    Application  = lower(var.app_name)
    BusinessUnit = lower(var.business_unit)
    CostCenter   = lower(var.cost_center)
    Environment  = lower(var.environment)
    Location     = lower(var.location)
  }
  all_tags = merge(local.default_tags, var.storage_account_tags)

}