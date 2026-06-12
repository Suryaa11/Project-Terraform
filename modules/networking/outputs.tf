output "vnet1_id" {
  description = "Application Gateway VNet ID."
  value       = azurerm_virtual_network.vnet1.id
}

output "vnet1_name" {
  description = "Application Gateway VNet name."
  value       = azurerm_virtual_network.vnet1.name
}

output "appgw_subnet_id" {
  description = "Application Gateway subnet ID."
  value       = azurerm_subnet.appgw.id
}

output "vnet2_id" {
  description = "App Services VNet ID."
  value       = azurerm_virtual_network.vnet2.id
}

output "vnet2_name" {
  description = "App Services VNet name."
  value       = azurerm_virtual_network.vnet2.name
}

output "app_private_endpoint_subnet_id" {
  description = "App Services private endpoint subnet ID."
  value       = azurerm_subnet.app_private_endpoint.id
}

output "app_integration_subnet_id" {
  description = "App Services VNet integration subnet ID."
  value       = azurerm_subnet.app_integration.id
}

output "vnet3_id" {
  description = "Data VNet ID."
  value       = azurerm_virtual_network.vnet3.id
}

output "vnet3_name" {
  description = "Data VNet name."
  value       = azurerm_virtual_network.vnet3.name
}

output "db_private_endpoint_subnet_id" {
  description = "Database private endpoint subnet ID."
  value       = azurerm_subnet.db_private_endpoint.id
}
