variable "name" {
  description = "VNet peering name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "virtual_network_name" {
  description = "Local virtual network name."
  type        = string
}

variable "remote_virtual_network_id" {
  description = "Remote virtual network ID."
  type        = string
}
