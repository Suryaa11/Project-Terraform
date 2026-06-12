resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

locals {
  frontend_app_name     = "frontend-app-${random_string.suffix.result}"
  microservice_app_name = "microservice-app-${random_string.suffix.result}"
  cosmosdb_account_name = "cosmosdb-account-${random_string.suffix.result}"
  storage_account_name  = lower(substr("staccount${random_string.suffix.result}", 0, 24))
}

module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.location
}

module "networking" {
  source = "./modules/networking"

  location                                     = var.location
  resource_group_name                          = module.resource_group.name
  vnet1_name                                   = "vnet-application-gateway"
  vnet1_address_space                          = var.vnet1_address_space
  appgw_subnet_name                            = "snet-application-gateway"
  appgw_subnet_address_prefixes                = var.appgw_subnet_address_prefixes
  vnet2_name                                   = "vnet-app-services"
  vnet2_address_space                          = var.vnet2_address_space
  app_private_endpoint_subnet_name             = "snet-app-private-endpoints"
  app_private_endpoint_subnet_address_prefixes = var.app_private_endpoint_subnet_address_prefixes
  app_integration_subnet_name                  = "snet-app-vnet-integration"
  app_integration_subnet_address_prefixes      = var.app_integration_subnet_address_prefixes
  vnet3_name                                   = "vnet-data"
  vnet3_address_space                          = var.vnet3_address_space
  db_private_endpoint_subnet_name              = "snet-db-private-endpoints"
  db_private_endpoint_subnet_address_prefixes  = var.db_private_endpoint_subnet_address_prefixes
}

module "vnet1_to_vnet2_peering" {
  source = "./modules/vnet_peering"

  name                      = "peer-vnet1-to-vnet2"
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.networking.vnet1_name
  remote_virtual_network_id = module.networking.vnet2_id
}

module "vnet2_to_vnet1_peering" {
  source = "./modules/vnet_peering"

  name                      = "peer-vnet2-to-vnet1"
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.networking.vnet2_name
  remote_virtual_network_id = module.networking.vnet1_id
}

module "vnet2_to_vnet3_peering" {
  source = "./modules/vnet_peering"

  name                      = "peer-vnet2-to-vnet3"
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.networking.vnet2_name
  remote_virtual_network_id = module.networking.vnet3_id
}

module "vnet3_to_vnet2_peering" {
  source = "./modules/vnet_peering"

  name                      = "peer-vnet3-to-vnet2"
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.networking.vnet3_name
  remote_virtual_network_id = module.networking.vnet2_id
}

module "private_dns" {
  source = "./modules/private_dns"

  location            = var.location
  resource_group_name = module.resource_group.name
  vnet1_id            = module.networking.vnet1_id
  vnet2_id            = module.networking.vnet2_id
  vnet3_id            = module.networking.vnet3_id
}

module "frontend_app_service" {
  source = "./modules/app_service"

  app_name                      = local.frontend_app_name
  plan_name                     = "frontend-app-plan"
  location                      = var.location
  resource_group_name           = module.resource_group.name
  sku_name                      = "S1"
  vnet_integration_subnet_id    = module.networking.app_integration_subnet_id
  public_network_access_enabled = false
}

module "microservice_app_service" {
  source = "./modules/app_service"

  app_name                      = local.microservice_app_name
  plan_name                     = "microservice-app-plan"
  location                      = var.location
  resource_group_name           = module.resource_group.name
  sku_name                      = "S1"
  vnet_integration_subnet_id    = module.networking.app_integration_subnet_id
  public_network_access_enabled = false
}

module "cosmosdb" {
  source = "./modules/cosmosdb"

  name                = local.cosmosdb_account_name
  location            = var.location
  cosmosdb_location   = var.cosmosdb_location
  resource_group_name = module.resource_group.name
}

module "storage" {
  source = "./modules/storage"

  name                = local.storage_account_name
  location            = var.location
  resource_group_name = module.resource_group.name
}

module "frontend_app_private_endpoint" {
  source = "./modules/private_endpoint"

  name                           = "frontend-app-pe"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.networking.app_private_endpoint_subnet_id
  private_connection_resource_id = module.frontend_app_service.app_id
  subresource_names              = ["sites"]
  private_dns_zone_ids           = [module.private_dns.azurewebsites_zone_id]
  private_dns_zone_name          = "privatelink.azurewebsites.net"
}

module "microservice_app_private_endpoint" {
  source = "./modules/private_endpoint"

  name                           = "microservice-app-pe"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.networking.app_private_endpoint_subnet_id
  private_connection_resource_id = module.microservice_app_service.app_id
  subresource_names              = ["sites"]
  private_dns_zone_ids           = [module.private_dns.azurewebsites_zone_id]
  private_dns_zone_name          = "privatelink.azurewebsites.net"
}

module "cosmos_private_endpoint" {
  source = "./modules/private_endpoint"

  name                           = "cosmos-pe"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.networking.db_private_endpoint_subnet_id
  private_connection_resource_id = module.cosmosdb.id
  subresource_names              = ["MongoDB"]
  private_dns_zone_ids           = [module.private_dns.cosmos_mongo_zone_id]
  private_dns_zone_name          = "privatelink.mongo.cosmos.azure.com"
}

module "blob_private_endpoint" {
  source = "./modules/private_endpoint"

  name                           = "blob-pe"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.networking.db_private_endpoint_subnet_id
  private_connection_resource_id = module.storage.id
  subresource_names              = ["blob"]
  private_dns_zone_ids           = [module.private_dns.blob_zone_id]
  private_dns_zone_name          = "privatelink.blob.core.windows.net"
}

module "application_gateway" {
  source = "./modules/application_gateway"

  name                      = "project-application-gateway"
  public_ip_name            = "project-agw-pip"
  location                  = var.location
  resource_group_name       = module.resource_group.name
  subnet_id                 = module.networking.appgw_subnet_id
  frontend_backend_fqdn     = module.frontend_app_service.default_hostname
  microservice_backend_fqdn = module.microservice_app_service.default_hostname

  depends_on = [
    module.frontend_app_private_endpoint,
    module.microservice_app_private_endpoint,
    module.vnet1_to_vnet2_peering,
    module.vnet2_to_vnet1_peering
  ]
}
