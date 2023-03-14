
# ------------------------------------------
# Workspace variables
#  - non-sensitive variables can be added to 'dev.auto.tfvars'
#  - secrets are set from Terraform Cloud
# ------------------------------------------

variable "azure_secret" {
  type = object({
    object_id       = string
    client_id       = string
    client_secret   = string
    subscription_id = string
    tenant_id       = string
  })
}

# variable "cnames" {
#   type = map(string)
# }

# ------------------------------------------
# Variable set vars
# ------------------------------------------

variable "atlas_secret" {
  type = object({
    org_id      = string
    public_key  = string
    private_key = string
    db_user     = string
    db_secret   = string
  })
}

variable "github_secret" {
  type = object({
    token = string
  })
}
