resource "azurerm_public_ip" "this" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101"
  }

  gateway_ip_configuration {
    name      = "app-gateway-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "public-frontend-ip"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  frontend_port {
    name = "http-port-80"
    port = 80
  }

  frontend_port {
    name = "http-port-8080"
    port = 8080
  }

  backend_address_pool {
    name  = "BackendPool1"
    fqdns = [var.frontend_backend_fqdn]
  }

  backend_address_pool {
    name  = "BackendPool2"
    fqdns = [var.microservice_backend_fqdn]
  }

  backend_http_settings {
    name                                = "https-settings"
    cookie_based_affinity               = "Disabled"
    pick_host_name_from_backend_address = true
    protocol                            = "Https"
    port                                = 443
    request_timeout                     = 30
  }

  http_listener {
    name                           = "Listener1"
    frontend_ip_configuration_name = "public-frontend-ip"
    frontend_port_name             = "http-port-80"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "Listener2"
    frontend_ip_configuration_name = "public-frontend-ip"
    frontend_port_name             = "http-port-8080"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "Rule1"
    rule_type                  = "Basic"
    http_listener_name         = "Listener1"
    backend_address_pool_name  = "BackendPool1"
    backend_http_settings_name = "https-settings"
    priority                   = 100
  }

  url_path_map {
    name                               = "microservice-path-map"
    default_backend_address_pool_name  = "BackendPool2"
    default_backend_http_settings_name = "https-settings"

    path_rule {
      name                       = "api-path"
      paths                      = ["/api", "/api/*"]
      backend_address_pool_name  = "BackendPool2"
      backend_http_settings_name = "https-settings"
    }
  }

  request_routing_rule {
    name               = "Rule2"
    rule_type          = "PathBasedRouting"
    http_listener_name = "Listener2"
    url_path_map_name  = "microservice-path-map"
    priority           = 110
  }
}
