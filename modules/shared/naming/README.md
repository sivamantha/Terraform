# Terraform Naming Module

Centralized module to generate standard, predictable names for all Azure resources. It handles region shorthand mappings and Azure's native constraints (like the 24-character limit and no hyphens for Storage Accounts).

## Why use this?
Don't guess or hardcode resource names. Feed this module your project and environment, and it'll spit out the exact strings to use for your `name` arguments, plus a standard tag block.

## Usage

```hcl
module "naming" {
  source = "./modules/shared/naming"

  project     = "dataplatform"
  environment = "prod"
  location    = "canadacentral"
  
  owner       = "data-engineering"
  cost_center = "analytics"
}

# Example: Naming a storage account
resource "azurerm_storage_account" "lake" {
  name     = module.naming.names["adls"]
  location = "canadacentral"
  tags     = module.naming.tags
}
```

## Inputs

| Name          | Type     | Required | Description                                 |
| ------------- | -------- | :------: | ------------------------------------------- |
| `project`     | `string` | **yes**  | Short project prefix (lowercase alpha only) |
| `environment` | `string` | **yes**  | `dev`, `staging`, or `prod`                 |
| `location`    | `string` |    no    | Azure region (default: `"canadacentral"`)   |
| `owner`       | `string` | **yes**  | Team responsible for the resources          |
| `cost_center` | `string` | **yes**  | Billing code/cost center                    |

## Outputs

When you call this module, grab these outputs for your resources:

*   `module.naming.names["<resource_type>"]` - The formatted resource name
*   `module.naming.tags` - Standard tag map
*   `module.naming.base` - The raw prefix (e.g. `dataplatformprodcac`)
*   `module.naming.resource_group_name` - Quick grab for the primary RG name

### Supported Resource Types (`names` map keys)

*   `resource_group`
*   `adls` *(Strips hyphens, capped at 24 chars)*
*   `adf`
*   `databricks`
*   `eventhub_namespace`
*   `keyvault` *(Capped at 24 chars)*
*   `log_analytics`

## Constraints built-in

- **Storage Names:** `var.project` strictly enforces lowercase alphanumeric `^[a-z0-9]+$` so we don't blow up Storage Account deployments.
- **Regions:** `var.location` ensures deployments stay within approved Canadian boundaries (`canadacentral` -> `cac` or `canadaeast` -> `cae`).
