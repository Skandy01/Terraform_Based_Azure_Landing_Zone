resource "azurerm_key_vault_secret" "kv_secret" {
    name=var.secret_name
    value=var.secret_value
    key_vault_id=var.kv_id
}