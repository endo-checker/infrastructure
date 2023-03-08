# -----------------------------------------------------------------------------
# Vnet creates vnet resources 
#  - deploys the container apps vnet and subnets
# -----------------------------------------------------------------------------

// vnet
resource "azurerm_virtual_network" "platform" {
  name                = "vnet-${var.namespace}"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "infrastructure" {
  name                 = "snet-infrastructure"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefixes     = ["10.0.0.0/23"]

  # delegation {
  #   name = "delegation"

  #   service_delegation {
  #     name    = "Microsoft.ContainerInstance/containerGroups"
  #     actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
  #   }
  # }
}

# add diagnostic logging
resource "azurerm_monitor_diagnostic_setting" "vnet" {
  name                       = "VnetLogs"
  target_resource_id         = azurerm_virtual_network.platform.id
  log_analytics_workspace_id = var.log_analytics_id

  enabled_log {
    category_group = "allLogs"
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
