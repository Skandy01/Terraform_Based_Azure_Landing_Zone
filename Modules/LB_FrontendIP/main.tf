resource "azurerm_lb" "lb" {
    name=var.lb_name
    location=var.location
    resource_group_name=var.RG_name

    frontend_ip_configuration {
        name=var.frontend_ip_config_name
        public_ip_address_id=var.pip_id
    }
}