resource "azurerm_subnet" "subnet" {
    name = var.subnet_name
    virtual_network_name = var.Vnet_name
    resource_group_name = var.RG_name
    address_prefixes=var.address_prefixes
}

