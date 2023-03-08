

output "key_vault_id" {
  value = azurerm_key_vault.apps.id
}

output "key_vault_name" {
  value = azurerm_key_vault.apps.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.apps.vault_uri
}