variable "name" {
  description = "Cosmos DB account name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "cosmosdb_location" {
  description = "Azure region for the Cosmos DB account write region."
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}
