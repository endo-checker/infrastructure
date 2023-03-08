#  add secrets to the key vault

resource "azurerm_key_vault_secret" "app" {
  for_each = var.app_secrets

  key_vault_id = azurerm_key_vault.apps.id
  name         = each.key
  value        = each.value
}
