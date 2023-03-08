
variable "namespace" {
  type = string
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "azure_secret" {
  type = object({
    object_id = string
    tenant_id = string
  })
}

variable "apps_managed_identity" {
  type = object({
    principal_id = string
  })
}

variable "subnet_id" {
  type = string
}

variable "app_secrets" {
  type = map(any)
}

variable "log_analytics_id" {
  type = string
}


