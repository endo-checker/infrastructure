# -----------------------------------------------------------------------------
# Web application infrastructure
# -----------------------------------------------------------------------------

resource "azurerm_static_site" "site" {
  name                = "stapp-${var.site_name}-${var.namespace}"
  location            = "westus2" # var.resource_group.location
  resource_group_name = var.resource_group.name

  sku_tier = "Standard"
  sku_size = "Standard"
}

resource "azurerm_dns_cname_record" "site" {
  zone_name           = var.subdomain
  resource_group_name = var.resource_group.name

  name   = var.site_name
  record = azurerm_static_site.site.default_host_name
  ttl    = 300
}

resource "azurerm_static_site_custom_domain" "site" {
  static_site_id  = azurerm_static_site.site.id
  domain_name     = "${azurerm_dns_cname_record.site.name}.${azurerm_dns_cname_record.site.zone_name}"
  validation_type = "cname-delegation"
}
