terraform {
  cloud {
    organization = "zachs-test"
    hostname     = "app.terraform.io"
    workspaces {
      name = "platform"
    }
  }
}

data "azurerm_subscription" "current" {}

# set up local variables
locals {
  environment = terraform.workspace
  env         = terraform.workspace
  namespace   = "platform"
  location    = "Australia East"
}

# Resource group
resource "azurerm_resource_group" "platform" {
  name     = "rg-${local.namespace}"
  location = local.location
}

# App insights
module "insights" {
  source         = "./modules/insights"
  namespace      = local.namespace
  resource_group = azurerm_resource_group.platform
}

# Virtual network
module "vnet" {
  source           = "./modules/vnet"
  namespace        = local.namespace
  resource_group   = azurerm_resource_group.platform
  log_analytics_id = module.insights.log_analytics_id
}


# # DNS zone
# module "dns" {
#   source         = "./modules/dns"
#   namespace      = local.namespace
#   resource_group = azurerm_resource_group.platform
#   subdomain      = "endo-checker.io"
#   cnames         = var.cnames
# }

# UserAssigned identities 
module "identity" {
  source         = "./modules/identity"
  namespace      = local.namespace
  resource_group = azurerm_resource_group.platform
}

# # Key vault
# module "key-vault" {
#   source                = "./modules/key-vault"
#   namespace             = local.namespace
#   resource_group        = azurerm_resource_group.platform
#   azure_secret          = var.azure_secret
#   apps_managed_identity = module.identity.apps
#   subnet_id             = module.vnet.subnets.controlplane_id
#   log_analytics_id      = module.insights.log_analytics_id
#   app_secrets = {
#     # TODO: add secrets from tf vars
#     # docStoreName = module.storage.name
#     # docStoreKey  = module.storage.primary_access_key
#     # mongoUri     = module.mongodb.private_endpoint_uri
#   }
# }

# Azure Container Apps + Dapr components
module "container-apps" {
  source           = "./modules/container-apps"
  namespace        = local.namespace
  resource_group   = azurerm_resource_group.platform
  subnet_id        = module.vnet.subnets.infrastructure_id
  log_analytics_id = module.insights.log_analytics_id
  managed_identity = module.identity.apps
}

# # MongoDB Atlas
# module "mongodb" {
#   source         = "./modules/mongodb"
#   namespace      = local.namespace
#   resource_group = azurerm_resource_group.platform
#   atlas_secret   = var.atlas_secret
#   subnet_id      = module.vnet.subnets.infrastructure_id
# }

# # Static sites
# module "web" {
#   source         = "./modules/web"
#   namespace      = local.namespace
#   resource_group = azurerm_resource_group.platform

#   for_each  = toset(["portal"])
#   subdomain = ""
#   site_name = each.key
# }

# Configure GitHub repos
# - read once rather than inside repo loop below
data "azuread_application" "sp" {
  display_name = "sp-${local.namespace}"
}

module "github" {
  source = "./modules/github"

  for_each = toset([
    "patient", "logger", "auth"
  ])

  namespace      = local.namespace
  resource_group = azurerm_resource_group.platform
  azure_secret   = var.azure_secret
  github_secret  = var.github_secret
  repo           = each.key
  app_obj_id     = data.azuread_application.sp.object_id
  env            = local.env
  environment    = local.environment
}
