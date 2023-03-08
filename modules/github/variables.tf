
variable "namespace" {
  type = string
}

variable "resource_group" {
  type = object({
    id       = string
    name     = string
    location = string
  })
}

variable "azure_secret" {
  type = object({
    client_id       = string
    client_secret   = string
    subscription_id = string
    tenant_id       = string
  })
}

variable "github_secret" {
  type = object({
    token = string
  })
}

variable "env" {
  type = string
}

variable "environment" {
  type = string
}

variable "repo" {
  type = string
}

variable "app_obj_id" {
  type = string
}