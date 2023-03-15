
locals {
  private_endpoint = concat(mongodbatlas_cluster.app.connection_strings[0].private_endpoint, tolist([{ srv_connection_string : "" }]))
}

# return private endpoint cnn string
output "private_endpoint_uri" {
  depends_on = [
    mongodbatlas_privatelink_endpoint_service.app
  ]
  value = local.private_endpoint[0].srv_connection_string
}
