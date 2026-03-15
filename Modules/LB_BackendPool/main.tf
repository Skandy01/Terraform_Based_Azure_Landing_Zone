resource "azurerm_lb_backend_address_pool" "LB_BackPool" {
    loadbalancer_id=var.loadbalancer_id
    name=var.backendPool_name
}