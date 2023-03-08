// Infrastructure network security group
resource "azurerm_network_security_group" "infrastructure" {
  name                = "nsg-infrastructure"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  # security_rule {
  #   name                       = "AllowAPIManagement"
  #   direction                  = "Inbound"
  #   source_address_prefix      = "ApiManagement"
  #   source_port_range          = "*"
  #   destination_address_prefix = "VirtualNetwork"
  #   destination_port_range     = "3443"
  #   protocol                   = "Tcp"
  #   access                     = "Allow"
  #   priority                   = 100
  # }
}
resource "azurerm_subnet_network_security_group_association" "infrastructure" {
  subnet_id                 = azurerm_subnet.infrastructure.id
  network_security_group_id = azurerm_network_security_group.infrastructure.id
}
resource "azurerm_monitor_diagnostic_setting" "infrastructure" {
  name                       = "NsgInfrastructureLogs"
  target_resource_id         = azurerm_network_security_group.infrastructure.id
  log_analytics_workspace_id = var.log_analytics_id

  enabled_log {
    category_group = "allLogs"
    retention_policy {
      days    = 0
      enabled = false
    }
  }
}
