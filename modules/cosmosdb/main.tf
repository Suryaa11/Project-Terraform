resource "azurerm_cosmosdb_account" "this" {
  name                              = var.name
  location                          = var.cosmosdb_location
  resource_group_name               = var.resource_group_name
  offer_type                        = "Standard"
  kind                              = "MongoDB"
  public_network_access_enabled     = false
  ip_range_filter                   = ""
  is_virtual_network_filter_enabled = false

  consistency_policy {
    consistency_level = "Session"
  }

  capabilities {
    name = "EnableMongo"
  }

  geo_location {
    location          = var.cosmosdb_location
    failover_priority = 0
  }
}
