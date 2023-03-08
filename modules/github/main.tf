# local 'import' is needed to access global settings (e.g. owner)
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.18.0"
    }
  }
}

locals {
  repo_name = "endo-checker/${var.repo}"
}

# data "github_repository" "repo" {
#   name = var.repo
# }

resource "github_repository_environment" "repo_env" {
  # repository  = data.github_repository.repo.name
  repository  = var.repo
  environment = var.environment

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

data "http" "deployment-branch" {
  url    = "https://api.github.com/repos/${local.repo_name}/environments/${github_repository_environment.repo_env.environment}/deployment-branch-policies"
  method = "POST"
  request_headers = {
    Accept        = "application/vnd.github+json"
    Authorization = "Bearer ${var.github_secret.token}"
  }
  request_body = "{\"name\":\"main\"}"

  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "Status code invalid"
    }
  }
}

resource "github_actions_environment_secret" "odic" {
  for_each = {
    AZURE_CLIENT_ID       = var.azure_secret.client_id
    AZURE_SUBSCRIPTION_ID = var.azure_secret.subscription_id
    AZURE_TENANT_ID       = var.azure_secret.tenant_id
  }
  # repository      = data.github_repository.repo.name
  repository      = var.repo
  environment     = github_repository_environment.repo_env.environment
  secret_name     = each.key
  plaintext_value = each.value
}

