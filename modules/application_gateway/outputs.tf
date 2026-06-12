output "id" {
  description = "Application Gateway ID."
  value       = azurerm_application_gateway.this.id
}

output "public_ip_address" {
  description = "Application Gateway public IP address."
  value       = azurerm_public_ip.this.ip_address
}
