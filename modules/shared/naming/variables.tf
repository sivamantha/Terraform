variable "project" {
  description = "Short project name used as prefix in all resource names"
  type        = string

  validation {
    # Azure storage accounts don't allow hyphens — keeping it alphanumeric
    # works for both Azure resources that allow hyphens and those that don't
    condition     = can(regex("^[a-z0-9]+$", var.project))
    error_message = "Project must be lowercase letters and numbers only. No hyphens."
  }
}

variable "environment" {
  description = "Deployment environment — controls naming and resource sizing"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "canadacentral"

  validation {
    condition = contains([
      "canadacentral",
      "canadaeast"
    ], var.location)
    error_message = "Location must be a supported Azure region."
  }
}

variable "owner" {
  description = "Team or person responsible for these resources — used in tags"
  type        = string
}

variable "cost_center" {
  description = "Cost center for billing — used in tags"
  type        = string
}
