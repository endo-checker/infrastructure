
variable "namespace" {
  type = string
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "subnet_id" {
  type = string
}

# variable "app_insights" {
#   type = object({
#     id                  = string
#     app_id              = string
#     instrumentation_key = string
#     connection_string   = string
#   })
# }

variable "log_analytics_id" {
  type = string
}

variable "managed_identity" {
  type = object({
    client_id = string
  })
}
