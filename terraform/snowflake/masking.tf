resource "snowflake_database_grant" "grant_db_for_masking" {
  provider          = snowflake.admin_security
  for_each          = snowflake_database.db
  database_name     = each.value.name
  privilege         = "USAGE"
  with_grant_option = false

  roles = [
    "SECURITYADMIN"
  ]
}

resource "snowflake_schema_grant" "grant_schema_for_masking" {
  # allow access to PUBLIC in each of the databases
  for_each      = snowflake_database.db
  database_name = each.value.name
  schema_name   = "PUBLIC"

  privilege = "USAGE"
  roles = [
    "SECURITYADMIN"
  ]
  with_grant_option = false
}

resource "snowflake_schema_grant" "create_mask_in_public" {
  # allow access to PUBLIC in each of the databases
  for_each      = snowflake_database.db
  database_name = each.value.name
  schema_name   = "PUBLIC"

  privilege = "CREATE MASKING POLICY"
  roles = [
    "SECURITYADMIN"
  ]
  with_grant_option = false
}

resource "snowflake_masking_policy" "PII_masking_policy" {
  provider = snowflake.admin_security
  for_each = snowflake_schema_grant.create_mask_in_public

  name               = "PII_MASK"
  database           = each.value.database_name
  schema             = each.value.schema_name
  value_data_type    = "varchar"
  masking_expression = "case when ARRAY_CONTAINS('PII_DATA'::VARIANT,parse_json(current_available_roles())) then val else '********' end"
  return_data_type   = "varchar"
}

resource "snowflake_masking_policy" "PII_variant_masking_policy" {
  provider = snowflake.admin_security
  for_each = snowflake_schema_grant.create_mask_in_public

  name               = "PII_MASK_VARIANT"
  database           = each.value.database_name
  schema             = each.value.schema_name
  value_data_type    = "VARIANT"
  masking_expression = "case when ARRAY_CONTAINS('PII_DATA'::VARIANT,parse_json(current_available_roles())) then val else NULL end"
  return_data_type   = "VARIANT"
}