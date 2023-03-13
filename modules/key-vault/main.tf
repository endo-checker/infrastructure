# -----------------------------------------------------------------------------
# Key Vault
# -----------------------------------------------------------------------------

resource "azurerm_key_vault" "apps" {
  name                = "kv-${var.namespace}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  sku_name  = "standard"
  tenant_id = var.azure_secret.tenant_id

  public_network_access_enabled = true
  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    virtual_network_subnet_ids = [var.subnet_id]
    ip_rules = [
      "210.54.238.207/32" # Zachary Weston
    ]
  }
  purge_protection_enabled    = true
  enabled_for_disk_encryption = true

  # Zachary Weston
  access_policy {
    tenant_id          = var.azure_secret.tenant_id
    object_id          = "78e4c655-726b-41f3-8305-0b3557d382a9"
    secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
  }

  # allow managed identity (id-endo-checker-${env}) to access secrets
  access_policy {
    tenant_id          = var.azure_secret.tenant_id
    object_id          = var.apps_managed_identity.principal_id
    secret_permissions = ["Get", "List"]
  }

  # allow dapr components to access secrets (sp-deployment-${env})
  access_policy {
    tenant_id               = var.azure_secret.tenant_id
    object_id               = var.azure_secret.object_id
    secret_permissions      = ["Get", "List", "Set", "Delete"]
    certificate_permissions = ["Get", "List", "Create", "Update", "Delete"]
  }
}

# audit logs for Key Vault
resource "azurerm_monitor_diagnostic_setting" "keyvault" {
  name                       = "KeyVaultLogs"
  target_resource_id         = azurerm_key_vault.apps.id
  log_analytics_workspace_id = var.log_analytics_id
  # log_analytics_destination_type = "Dedicated"

  log {
    category_group = "allLogs"
    enabled        = false
    retention_policy {
      days    = 0
      enabled = false
    }
  }
  log {
    category_group = "audit"
    enabled        = true
    retention_policy {
      days    = 0
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = false
    }
  }
}
