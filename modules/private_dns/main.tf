resource "azurerm_private_dns_zone" "azurewebsites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "cosmos_mongo" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites_vnet1" {
  name                  = "azurewebsites-vnet1-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.azurewebsites.name
  virtual_network_id    = var.vnet1_id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites_vnet2" {
  name                  = "azurewebsites-vnet2-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.azurewebsites.name
  virtual_network_id    = var.vnet2_id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites_vnet3" {
  name                  = "azurewebsites-vnet3-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.azurewebsites.name
  virtual_network_id    = var.vnet3_id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "cosmos_mongo_vnet2" {
  name                  = "cosmos-mongo-vnet2-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.cosmos_mongo.name
  virtual_network_id    = var.vnet2_id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "cosmos_mongo_vnet3" {
  name                  = "cosmos-mongo-vnet3-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.cosmos_mongo.name
  virtual_network_id    = var.vnet3_id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_vnet2" {
  name                  = "blob-vnet2-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = var.vnet2_id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_vnet3" {
  name                  = "blob-vnet3-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = var.vnet3_id
  registration_enabled  = false
}
