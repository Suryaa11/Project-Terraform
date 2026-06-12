variable "location" {
  description = "Azure region for all resources."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "cosmosdb_location" {
  description = "Azure region for the Cosmos DB account write region."
  type        = string
  default     = "Central India"
}

variable "vnet1_address_space" {
  description = "Address space for the Application Gateway virtual network."
  type        = list(string)
}

variable "appgw_subnet_address_prefixes" {
  description = "Address prefixes for the Application Gateway subnet."
  type        = list(string)
}

variable "vnet2_address_space" {
  description = "Address space for the App Services virtual network."
  type        = list(string)
}

variable "app_private_endpoint_subnet_address_prefixes" {
  description = "Address prefixes for the App Services private endpoint subnet."
  type        = list(string)
}

variable "app_integration_subnet_address_prefixes" {
  description = "Address prefixes for the App Services VNet integration subnet."
  type        = list(string)
}

variable "vnet3_address_space" {
  description = "Address space for the database virtual network."
  type        = list(string)
}

variable "db_private_endpoint_subnet_address_prefixes" {
  description = "Address prefixes for the database private endpoint subnet."
  type        = list(string)
}
