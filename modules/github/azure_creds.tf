
# data "azuread_application" "sp" {
#   display_name = "sp-deployment-${var.env}"
# }

resource "azuread_application_federated_identity_credential" "repo" {
  application_object_id = var.app_obj_id
  display_name          = "${var.repo}-deploy"
  description           = "Deployments for ${var.repo} service"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:${local.repo_name}:environment:${var.environment}"
}

locals {
  repo_name = "endo-checker/${var.repo}"
}