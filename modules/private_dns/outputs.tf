output "azurewebsites_zone_id" {
  description = "Private DNS zone ID for Azure App Service."
  value       = azurerm_private_dns_zone.azurewebsites.id
}

output "cosmos_mongo_zone_id" {
  description = "Private DNS zone ID for Cosmos DB MongoDB API."
  value       = azurerm_private_dns_zone.cosmos_mongo.id
}

output "blob_zone_id" {
  description = "Private DNS zone ID for Blob Storage."
  value       = azurerm_private_dns_zone.blob.id
}
