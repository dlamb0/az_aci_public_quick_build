# -------------------------------------------------------
# variables.tf
# Fill in your values here before running terraform apply
# -------------------------------------------------------

# Your Azure Subscription ID
# Find this by running: az account list --output table
variable "subscription_id" {
  type      = string
  default   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  sensitive = true
}

# Azure Resource Group for your personal labs
variable "resource_group_name" {
  type    = string
  default = "your-resource-group"
}

# Prefix name for all resources - lowercase letters, numbers, hyphens only
# Resources will be named: <app_base_name>-acg, -identity, etc
variable "app_base_name" {
  type    = string
  default = "application-name"
}

# Azure region - options: eastus2, centralus, westus2
variable "location" {
  type    = string
  default = "westus2"
}

# ACR ID used for authentication
variable "acr_id" {
  type    = string
  default = "/subscriptions/xxxxxxxx.xxxx.xxxx.xxxx.xxxxxxxxxxxx/resourceGroups/your-resourece-group/providers/Microsoft.ContainerRegistry/registries/your-acr"
}

# ACR server URL
variable "acr_login_server" {
  type    = string
  default = "your-acr.azurecr.io"
}

# Docker container image to deploy
variable "container_image" {
  type    = string
  default = "your-acr.azurecr.io/application-name:latest"
}

# Your email address - applied as an owner tag on all resources
variable "owner_email" {
  type    = string
  default = "your@email.com"
}

# Environment label for tagging
variable "environment" {
  type    = string
  default = "lab"
}
