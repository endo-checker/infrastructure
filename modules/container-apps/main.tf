# -----------------------------------------------------------------------------
# Container App creates container app resources 
#  - deploys managed environment and dapr components
# -----------------------------------------------------------------------------

resource "azurerm_container_app_environment" "platform" {
  name                = "cae-${var.namespace}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  log_analytics_workspace_id     = var.log_analytics_id
  infrastructure_subnet_id       = var.subnet_id
  internal_load_balancer_enabled = false
}

# audit logs for Container Apps
resource "azurerm_monitor_diagnostic_setting" "containerapps" {
  name                           = "ContainerAppLogs"
  target_resource_id             = azurerm_container_app_environment.platform.id
  log_analytics_workspace_id     = var.log_analytics_id
  log_analytics_destination_type = "AzureDiagnostics" # "Dedicated" makes it difficult to find logs

  enabled_log {
    category_group = "audit"
    retention_policy {
      days    = 0
      enabled = false
    }
  }

  enabled_log {
    category_group = "allLogs"
    retention_policy {
      days    = 0
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}
