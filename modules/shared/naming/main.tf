# =============================================================================
# Generates consistent, predictable names for every Azure resource.
#
# Naming pattern:
#   {project}{environment}{region_short}-{resource_type}
#
# Example:
#   project=dataplatform, environment=dev, location=canadacentral
#   → dataplatformdevcac-adls
#   → dataplatformdevcac-databricks
#   → dataplatformdevcac-kv
# =============================================================================

locals {
  region_short = {
    "canadacentral" = "cac"
    "canadaeast"    = "cae"
  }

  base = lower("${var.project}${var.environment}${local.region_short[var.location]}")

  names = {
    resource_group     = "${local.base}-rg"
    adls               = substr(replace("${local.base}adls", "-", ""), 0, 24)
    adf                = "${local.base}-adf"
    databricks         = "${local.base}-dbx"
    eventhub_namespace = "${local.base}-ehns"
    keyvault           = substr("${local.base}-kv", 0, 24)
    log_analytics      = "${local.base}-law"
  }

  tags = {
    project     = var.project
    environment = var.environment
    location    = var.location
    owner       = var.owner
    cost_center = var.cost_center
    managed_by  = "terraform"
  }
}
