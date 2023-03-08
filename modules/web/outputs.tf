
# output "host_names" {
#   value = [
#     for s in azurerm_static_site.site : "https://${s.default_host_name}"
#   ]
# }

output "api_key" {
  value = azurerm_static_site.site.api_key
}
