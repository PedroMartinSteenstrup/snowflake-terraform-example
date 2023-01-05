# Example how to access a loop in another file to apply one set of
# roles to several objects at once
resource "snowflake_database_grant" "grant" {
  provider          = snowflake.admin_security
  for_each          = snowflake_database.db
  database_name     = each.key
  privilege         = "USAGE"
  with_grant_option = false

  roles = [
    snowflake_role.role["TRANSFORMER"].name,
    snowflake_role.role["INGESTER"].name
  ]
}

resource "snowflake_schema_grant" "grant" {
  provider          = snowflake.admin_security
  database_name     = snowflake_database.airbyte.name
  schema_name       = snowflake_schema.airbyte_landing.name
  privilege         = "USAGE"
  with_grant_option = false

  roles = [
    snowflake_role.role["TRANSFORMER"].name,
    snowflake_role.role["INGESTER"].name
  ]

}

resource "snowflake_schema_grant" "external_stage_schema_usage" {
  provider  = snowflake.admin_system
  privilege = "USAGE"
  roles     = ["SYSADMIN", "INGESTER", "TRANSFORMER"]

  database_name = snowflake_schema.schema_external_tables.database
  schema_name   = snowflake_schema.schema_external_tables.name
}

#resource "snowflake_warehouse_grant" "grant" {
#  provider          = snowflake.security_admin
#  warehouse_name    = snowflake_warehouse.warehouse.name
#  privilege         = "USAGE"
#  roles             = [snowflake_role.role.name]
#  with_grant_option = false
#}
#
#resource "snowflake_role_grants" "grants" {
#  provider  = snowflake.security_admin
#  role_name = snowflake_role.role.name
#  users     = [snowflake_user.user.name]
#}