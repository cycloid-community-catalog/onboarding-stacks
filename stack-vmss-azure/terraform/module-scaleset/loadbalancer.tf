# Create Public IP Address for Azure Load Balancer
resource "azurerm_public_ip" "lbpublicip" {
  name                = "${var.project}-${var.env}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku = "Standard"

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}"
    role = "public_ip"
  })
}

# Create Azure Standard Load Balancer
resource "azurerm_lb" "web_lb" {
  name                = "${var.project}-${var.env}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lbpublicip.id
  }

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}"
    role = "loadbalancer"
  })
}

# Create LB Backend Pool
resource "azurerm_lb_backend_address_pool" "web_lb_backend_address_pool" {
  name                = "${var.project}-${var.env}"
  loadbalancer_id     = azurerm_lb.web_lb.id
}

# Create LB Probe
resource "azurerm_lb_probe" "web_lb_probe" {
  name                = "${var.project}-${var.env}"
  protocol            = "Tcp"
  port                = 80
  loadbalancer_id     = azurerm_lb.web_lb.id
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Create LB Rule
resource "azurerm_lb_rule" "web_lb_rule_app1" {
  name                           = "${var.project}-${var.env}-HTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id 
  probe_id                       = azurerm_lb_probe.web_lb_probe.id
  loadbalancer_id                = azurerm_lb.web_lb.id
  resource_group_name            = data.azurerm_resource_group.rg.name
}