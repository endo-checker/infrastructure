
variable "namespace" {
  type = string
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "subdomain" {
  type = string
}

variable "site_name" {
  type = string
}