variable "name" {
  description = "Application Gateway name."
  type        = string
}

variable "public_ip_name" {
  description = "Application Gateway public IP name."
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
  description = "Application Gateway subnet ID."
  type        = string
}

variable "frontend_backend_fqdn" {
  description = "Frontend App Service default hostname."
  type        = string
}

variable "microservice_backend_fqdn" {
  description = "Microservice App Service default hostname."
  type        = string
}
