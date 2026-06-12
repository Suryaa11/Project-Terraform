variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "vnet1_name" {
  description = "Application Gateway VNet name."
  type        = string
}

variable "vnet1_address_space" {
  description = "Application Gateway VNet address space."
  type        = list(string)
}

variable "appgw_subnet_name" {
  description = "Application Gateway subnet name."
  type        = string
}

variable "appgw_subnet_address_prefixes" {
  description = "Application Gateway subnet prefixes."
  type        = list(string)
}

variable "vnet2_name" {
  description = "App Services VNet name."
  type        = string
}

variable "vnet2_address_space" {
  description = "App Services VNet address space."
  type        = list(string)
}

variable "app_private_endpoint_subnet_name" {
  description = "App private endpoint subnet name."
  type        = string
}

variable "app_private_endpoint_subnet_address_prefixes" {
  description = "App private endpoint subnet prefixes."
  type        = list(string)
}

variable "app_integration_subnet_name" {
  description = "App VNet integration subnet name."
  type        = string
}

variable "app_integration_subnet_address_prefixes" {
  description = "App VNet integration subnet prefixes."
  type        = list(string)
}

variable "vnet3_name" {
  description = "Data VNet name."
  type        = string
}

variable "vnet3_address_space" {
  description = "Data VNet address space."
  type        = list(string)
}

variable "db_private_endpoint_subnet_name" {
  description = "Database private endpoint subnet name."
  type        = string
}

variable "db_private_endpoint_subnet_address_prefixes" {
  description = "Database private endpoint subnet prefixes."
  type        = list(string)
}
