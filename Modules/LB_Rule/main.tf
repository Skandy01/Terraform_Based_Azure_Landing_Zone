resource "azurerm_lb_rule" "lb_rule" {
    loadbalancer_id=var.loadbalancer_id
    name=var.lbRule_name
    protocol=var.protocol
    frontend_port=var.frontend_port
    backend_port=var.backend_port
    frontend_ip_configuration_name=var.frontend_ip_config_name
}