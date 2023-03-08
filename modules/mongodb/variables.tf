
variable "namespace" {
  type = string
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "atlas_secret" {
  type = object({
    org_id      = string
    public_key  = string
    private_key = string
    db_user     = string
    db_secret   = string
  })
}

variable "subnet_id" {
  type = string
}
