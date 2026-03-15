resource "azurerm_mssql_server" "sql_server" {
    name=var.sql_server_name
    location=var.location
    resource_group_name=var.RG_name
    version=var.version
    administrator_login=var.admin_login
    administrator_login_password=var.admin_pass
}