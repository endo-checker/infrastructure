
output "managed_env_id" {
  value = azurerm_container_app_environment.platform.id
  # sensitive = true
}
