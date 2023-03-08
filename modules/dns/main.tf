
resource "azurerm_dns_zone" "endo-checker" {
  name                = var.subdomain
  resource_group_name = "rg-endo-checker-tools" # var.resource_group.name

  soa_record {
    host_name    = "ns1-35.azure-dns.com."
    email        = "azuredns-hostmaster.microsoft.com"
    expire_time  = 2419200
    minimum_ttl  = 300
    refresh_time = 3600
    retry_time   = 300
    ttl          = 3600
  }
}

resource "azurerm_dns_cname_record" "app" {
  zone_name           = azurerm_dns_zone.endo-checker.name
  resource_group_name = "rg-endo-checker-tools" # var.resource_group.name

  for_each = var.cnames
  name     = each.key
  record   = each.value
  ttl      = 300
}

