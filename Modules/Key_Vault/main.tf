resource "azurerm_key_vault" "kv" {
    name=var.kv_name
    location=var.location
    resource_group_name=var.RG_name