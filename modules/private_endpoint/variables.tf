variable "name" {
  description = "Private endpoint name."
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

variable "subnet_id" {
  description = "Subnet ID for the private endpoint."
  type        = string
}

variable "private_connection_resource_id" {
  description = "Target resource ID for the private endpoint."
  type        = string
}

variable "subresource_names" {
  description = "Target subresource names."
  type        = list(string)
}

variable "private_dns_zone_ids" {
  description = "Private DNS zone IDs for the DNS zone group."
  type        = list(string)
}

variable "private_dns_zone_name" {
  description = "Name to use for the private DNS zone group."
  type        = string
}
