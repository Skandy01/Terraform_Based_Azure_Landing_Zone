module "RG" {
  source   = "../Modules/RG"
  RG_name  = var.RG_name
  location = var.location
}

module "Vnet" {
  source        = "../Modules/VNet"
  depends_on    = [module.RG]
  Vnet_name     = var.Vnet_name
  location      = var.location
  RG_name       = var.RG_name
  address_space = var.address_space
}

module "Subnet1" {
  source           = "../Modules/Subnet"
  depends_on       = [module.Vnet]
  subnet_name      = var.subnet1_name
  Vnet_name        = var.Vnet_name
  RG_name          = var.RG_name
  address_prefixes = var.address_prefixes1
}

module "Subnet2" {
  source           = "../Modules/Subnet"
  depends_on       = [module.Vnet]
  subnet_name      = var.subnet2_name
  Vnet_name        = var.Vnet_name
  RG_name          = var.RG_name
  address_prefixes = var.address_prefixes2
}

module "Public_IP_Bastion" {
  source            = "../Modules/PublicIP"
  depends_on        = [module.RG]
  pip_name          = var.BASTIONpip_name
  RG_name           = var.RG_name
  location          = var.location
  allocation_method = var.allocation_method
}

module "Public_IP_LB" {
  source            = "../Modules/PublicIP"
  depends_on        = [module.RG]
  pip_name          = var.LBpip_name
  RG_name           = var.RG_name
  location          = var.location
  allocation_method = var.allocation_method
}

module "bastion" {
  source         = "../Modules/Bastion"
  depends_on     = [module.Public_IP_Bastion, module.Subnet1]
  bastion_name   = var.bastion_name
  RG_name        = var.RG_name
  location       = var.location
  ip_config_name = var.ip_config_name_bastion
  subnet_id      = data.azurerm_subnet.subnet1_id.id
  pip_id         = data.azurerm_public_ip.pipBastion_id.id
}

module "nic1" {
  source         = "../Modules/NIC"
  depends_on     = [module.Subnet2]
  NIC_name       = var.nic1_name
  location       = var.location
  RG_name        = var.RG_name
  ip_config_name = var.ip_config_name_nic1
  subnet_id      = data.azurerm_subnet.subnet2_id.id
  pip_allocation = var.pip_allocation
}

module "nic2" {
  source         = "../Modules/NIC"
  depends_on     = [module.Subnet2]
  NIC_name       = var.nic2_name
  location       = var.location
  RG_name        = var.RG_name
  ip_config_name = var.ip_config_name_nic2
  subnet_id      = data.azurerm_subnet.subnet2_id.id
  pip_allocation = var.pip_allocation
}

module "vm1" {
  source               = "../Modules/VM"
  depends_on           = [module.nic1]
  vm_name              = var.vm1_name
  location             = var.location
  RG_name              = var.RG_name
  vm_size              = var.vm1_size
  admin_username       = var.admin_username1
  admin_password       = var.admin_password1
  nic_id               = data.azurerm_network_interface.nic1_id.id
  os_disk_caching      = var.os_disk_caching1
  storage_account_type = var.storage_account_type1
  image_publisher      = var.image_publisher1
  image_offer          = var.image_offer1
  image_sku            = var.image_sku1
  image_version        = var.image_version1
}

module "vm2" {
  source               = "../Modules/VM"
  depends_on           = [module.nic2]
  vm_name              = var.vm2_name
  location             = var.location
  RG_name              = var.RG_name
  vm_size              = var.vm2_size
  admin_username       = var.admin_username2
  admin_password       = var.admin_password2
  nic_id               = data.azurerm_network_interface.nic2_id.id
  os_disk_caching      = var.os_disk_caching2
  storage_account_type = var.storage_account_type2
  image_publisher      = var.image_publisher2
  image_offer          = var.image_offer2
  image_sku            = var.image_sku2
  image_version        = var.image_version2
}

module "lb_frontendIP" {
  source                  = "../Modules/LB_FrontendIP"
  depends_on              = [module.RG, module.Public_IP_LB]
  lb_name                 = var.lb_name
  location                = var.location
  RG_name                 = var.RG_name
  frontend_ip_config_name = var.frontend_ip_config_name
  pip_id                  = data.azurerm_public_ip.pipLB_id.id
}

module "lb_backPool" {
  source           = "../Modules/LB_BackendPool"
  depends_on       = [module.lb_frontendIP]
  loadbalancer_id  = data.azurerm_lb.lb_id.id
  backendPool_name = var.backendPool_name
}

module "lb_rule" {
  source                  = "../Modules/LB_Rule"
  depends_on              = [module.lb_frontendIP]
  loadbalancer_id         = data.azurerm_lb.lb_id.id
  lbRule_name             = var.lbRule_name
  protocol                = var.protocol
  frontend_port           = var.frontend_port
  backend_port            = var.backend_port
  frontend_ip_config_name = var.frontend_ip_config_name
}

module "lb_probe" {
  source          = "../Modules/LB_Probe"
  depends_on      = [module.lb_frontendIP]
  loadbalancer_id = data.azurerm_lb.lb_id.id
  lb_probe_name   = var.lb_probe_name
  lb_probe_port   = var.lb_probe_port
}

module "nic1_pool" {
  source          = "../Modules/LB_VM_Association"
  depends_on      = [module.nic1, module.lb_backPool]
  nic_id          = data.azurerm_network_interface.nic1_id.id
  ip_config_name  = var.ip_config_name_nic1
  backend_pool_id = data.azurerm_lb_backend_address_pool.lb_pool_id.id
}

module "nic2_pool" {
  source          = "../Modules/LB_VM_Association"
  depends_on      = [module.nic2, module.lb_backPool]
  nic_id          = data.azurerm_network_interface.nic2_id.id
  ip_config_name  = var.ip_config_name_nic2
  backend_pool_id = data.azurerm_lb_backend_address_pool.lb_pool_id.id
}

module "nsg" {
  source                     = "../Modules/NSG"
  depends_on                 = [module.Subnet2]
  nsg_name                   = var.nsg_name
  location                   = var.location
  RG_name                    = var.RG_name
  security_rule_name         = var.security_rule_name
  priority                   = var.priority
  direction                  = var.direction
  access                     = var.access
  protocol                   = var.protocol
  source_port_range          = var.source_port_range
  destination_port_range     = var.destination_port_range
  source_address_prefix      = var.source_address_prefix
  destination_address_prefix = var.destination_address_prefix
}

module "subnet_nsg_assoc" {
  source    = "../Modules/Subnet_NSG_Association"
  subnet_id = data.azurerm_subnet.subnet2_id.id
  nsg_id    = data.azurerm_network_security_group.nsg_id.id
}
