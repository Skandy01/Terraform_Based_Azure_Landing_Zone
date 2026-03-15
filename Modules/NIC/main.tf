resource "azurerm_network_interface" "NIC" {
    name=var.NIC_name
    location=var.location
    resource_group_name=var.RG_name

    ip_configuration {
        name=var.ip_config_name
        subnet_id=var.subnet_id
        private_ip_address_allocation=var.pip_allocation
    }
}