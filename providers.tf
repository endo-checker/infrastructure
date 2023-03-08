terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.46.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.35.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.3.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.18.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.8.0"
    }
  }
}

# ----------------------------------------------------------------
# configure providers — they are automatically available to child 
# modules
# ----------------------------------------------------------------
provider "azurerm" {
  client_id       = var.azure_secret.client_id
  client_secret   = var.azure_secret.client_secret
  subscription_id = var.azure_secret.subscription_id
  tenant_id       = var.azure_secret.tenant_id
  # use_oidc        = true
  features {}
}

provider "azuread" {
  client_id     = var.azure_secret.client_id
  client_secret = var.azure_secret.client_secret
  tenant_id     = var.azure_secret.tenant_id
  # use_oidc = true
}

provider "github" {
  token = var.github_secret.token
  owner = "endo-checker"
}

provider "http" {

}

provider "mongodbatlas" {
  public_key  = var.atlas_secret.public_key
  private_key = var.atlas_secret.private_key
}
