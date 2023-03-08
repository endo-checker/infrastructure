
# private endpoint
resource "mongodbatlas_privatelink_endpoint" "app" {
  project_id    = mongodbatlas_project.app.id
  provider_name = "AZURE"
  region        = "australiaeast"
}

# create Azure end for endpoint
resource "azurerm_private_endpoint" "mongodb" {
  name                = "pl-mongodb-${var.namespace}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = mongodbatlas_privatelink_endpoint.app.private_link_service_name
    private_connection_resource_id = mongodbatlas_privatelink_endpoint.app.private_link_service_resource_id
    is_manual_connection           = true
    request_message                = "PL"
  }
}

# create endpoint service on MongoDB
resource "mongodbatlas_privatelink_endpoint_service" "app" {
  project_id                  = mongodbatlas_project.app.id
  provider_name               = "AZURE"
  private_link_id             = mongodbatlas_privatelink_endpoint.app.private_link_id
  endpoint_service_id         = azurerm_private_endpoint.mongodb.id
  private_endpoint_ip_address = azurerm_private_endpoint.mongodb.private_service_connection[0].private_ip_address
}
