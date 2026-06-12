resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet1_address_space
}

resource "azurerm_subnet" "appgw" {
  name                 = var.appgw_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = var.appgw_subnet_address_prefixes
}

resource "azurerm_virtual_network" "vnet2" {
  name                = var.vnet2_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet2_address_space
}

resource "azurerm_subnet" "app_private_endpoint" {
  name                              = var.app_private_endpoint_subnet_name
  resource_group_name               = var.resource_group_name
  virtual_network_name              = azurerm_virtual_network.vnet2.name
  address_prefixes                  = var.app_private_endpoint_subnet_address_prefixes
  private_endpoint_network_policies = "Disabled"
}

resource "azurerm_subnet" "app_integration" {
  name                 = var.app_integration_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = var.app_integration_subnet_address_prefixes

  delegation {
    name = "webapp-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_virtual_network" "vnet3" {
  name                = var.vnet3_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet3_address_space
}

resource "azurerm_subnet" "db_private_endpoint" {
  name                              = var.db_private_endpoint_subnet_name
  resource_group_name               = var.resource_group_name
  virtual_network_name              = azurerm_virtual_network.vnet3.name
  address_prefixes                  = var.db_private_endpoint_subnet_address_prefixes
  private_endpoint_network_policies = "Disabled"
}
