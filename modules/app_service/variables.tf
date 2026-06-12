variable "app_name" {
  description = "Linux Web App name."
  type        = string
}

variable "plan_name" {
  description = "Service plan name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "sku_name" {
  description = "Service plan SKU."
  type        = string
}

variable "vnet_integration_subnet_id" {
  description = "Subnet ID for regional VNet integration."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the web app."
  type        = bool
}
