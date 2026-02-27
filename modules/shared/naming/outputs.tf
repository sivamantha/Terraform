# =============================================================================
# Outputs from the naming module.
# Other modules consume these — they never generate their own names.
#
# Usage in another module:
#   module "naming" {
#     source      = "../../modules/shared/naming"
#     project     = "dataplatform"
#     environment = "dev"
#     location    = "canadacentral"
#   }
#
#   resource "azurerm_resource_group" "main" {
#     name = module.naming.names["resource_group"]
#   }
# =============================================================================

output "names" {
  description = "Map of all standardized resource names for this environment"
  value       = local.names
}

output "tags" {
  description = "Standard tags to apply to every resource"
  value       = local.tags
}

output "base" {
  description = "Base prefix string — use this when you need a custom name not in the names map"
  value       = local.base
}

output "resource_group_name" {
  description = "Shortcut output for the resource group name — used by almost every module"
  value       = local.names["resource_group"]
}
