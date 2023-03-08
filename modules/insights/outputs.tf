
output "app_insights" {
  value = azurerm_application_insights.platform
  # sensitive = true
}

output "log_analytics_id" {
  value = azurerm_log_analytics_workspace.platform.id
}
