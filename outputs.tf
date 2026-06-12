output "application_gateway_public_ip" {
  description = "Public IP address of the Application Gateway."
  value       = module.application_gateway.public_ip_address
}

output "frontend_app_service_url" {
  description = "Default URL for the frontend App Service."
  value       = "https://${module.frontend_app_service.default_hostname}"
}

output "microservice_app_service_url" {
  description = "Default URL for the microservice App Service."
  value       = "https://${module.microservice_app_service.default_hostname}"
}

output "cosmosdb_connection_string" {
  description = "Primary MongoDB connection string for Cosmos DB."
  value       = module.cosmosdb.primary_mongodb_connection_string
  sensitive   = true
}

output "storage_account_name" {
  description = "Storage account name."
  value       = module.storage.name
}

output "vnet1_id" {
  description = "Application Gateway VNet ID."
  value       = module.networking.vnet1_id
}

output "vnet2_id" {
  description = "App Services VNet ID."
  value       = module.networking.vnet2_id
}

output "vnet3_id" {
  description = "Data VNet ID."
  value       = module.networking.vnet3_id
}
