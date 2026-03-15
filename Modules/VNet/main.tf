resource "azurerm_virtual_network" "Vnet" {
    name = var.Vnet_name
    location = var.location
    resource_group_name = var.RG_name
    address_space=var.address_space
}