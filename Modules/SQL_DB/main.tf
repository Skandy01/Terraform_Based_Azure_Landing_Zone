resource "azurerm_mssql_db" "sql_db" {
    name=var.sql_db_name
    server_id=var.server_id
}