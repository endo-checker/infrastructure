resource "azurerm_user_assigned_identity" "platform" {
  name                = "id-${var.namespace}"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
}
