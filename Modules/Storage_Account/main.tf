resource "azurerm_storage_account" "stg" {
    name=var.stg_name
    location=var.location
    resource_group_name=var.RG_name
    account_tier=var.account_tier
    account_replication_type=var.acct_rep_type
}