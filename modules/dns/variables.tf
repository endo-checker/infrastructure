
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

variable "cnames" {
  type = map(string)
}
