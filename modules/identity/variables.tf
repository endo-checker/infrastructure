
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

