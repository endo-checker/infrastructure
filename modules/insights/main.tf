# -----------------------------------------------------------------------------
# Application Insights 
#  - use output to connect services
# -----------------------------------------------------------------------------

resource "azurerm_log_analytics_workspace" "platform" {
  name                = "log-${var.namespace}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  sku               = "PerGB2018"
  retention_in_days = 30
  daily_quota_gb    = 5
}

resource "azurerm_application_insights" "platform" {
  name                = "appi-${var.namespace}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  workspace_id     = azurerm_log_analytics_workspace.platform.id
  application_type = "web"
}