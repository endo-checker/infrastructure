
output "vnet" {
  value = {
    id   = azurerm_virtual_network.platform.id
    name = azurerm_virtual_network.platform.name
  }
}

output "subnets" {
  value = {
    infrastructure_id = azurerm_subnet.infrastructure.id
  }
}