

resource "azurerm_container_registry" "acr" {
  name                = "acrendochecker"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  sku                 = "Standard"

  admin_enabled = true

  # identity {
  #   type = "UserAssigned"
  #   identity_ids = [
  #     azurerm_user_assigned_identity.example.id
  #   ]
  # }

  # encryption {
  #   enabled            = true
  #   key_vault_key_id   = data.azurerm_key_vault_key.example.id
  #   identity_client_id = azurerm_user_assigned_identity.example.client_id
  # }
}
