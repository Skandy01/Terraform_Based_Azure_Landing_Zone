data "azurerm_subnet" "subnet1_id" {
  name                 = var.subnet1_name
  depends_on           = [module.Subnet1]
  virtual_network_name = var.Vnet_name
  resource_group_name  = var.RG_name
}

data "azurerm_subnet" "subnet2_id" {
  name                 = var.subnet2_name
  depends_on           = [module.Subnet2]
  virtual_network_name = var.Vnet_name
  resource_group_name  = var.RG_name
}

data "azurerm_public_ip" "pipBastion_id" {
  name                = var.BASTIONpip_name
  depends_on          = [module.Public_IP_Bastion]
  resource_group_name = var.RG_name
}

data "azurerm_public_ip" "pipLB_id" {
  name                = var.LBpip_name
  depends_on          = [module.Public_IP_LB]
  resource_group_name = var.RG_name
}

data "azurerm_network_interface" "nic1_id" {
  name                = var.nic1_name
  depends_on          = [module.nic1]
  resource_group_name = var.RG_name
}

data "azurerm_network_interface" "nic2_id" {
  name                = var.nic2_name
  depends_on          = [module.nic2]
  resource_group_name = var.RG_name
}

data "azurerm_lb" "lb_id" {
  name                = var.lb_name
  depends_on          = [module.lb_frontendIP]
  resource_group_name = var.RG_name
}

data "azurerm_lb_backend_address_pool" "lb_pool_id" {
  name            = var.backendPool_name
  depends_on      = [module.lb_backPool]
  loadbalancer_id = data.azurerm_lb.lb_id.id
}

data "azurerm_network_security_group" "nsg_id" {
  name                = var.nsg_name
  depends_on          = [module.nsg]
  resource_group_name = var.RG_name
}