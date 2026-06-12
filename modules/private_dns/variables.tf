variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "vnet1_id" {
  description = "Application Gateway VNet ID."
  type        = string
}

variable "vnet2_id" {
  description = "App Services VNet ID."
  type        = string
}

variable "vnet3_id" {
  description = "Data VNet ID."
  type        = string
}
