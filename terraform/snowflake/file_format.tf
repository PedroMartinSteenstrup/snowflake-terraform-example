## seems compression is q required property, otherwise terraform sees it as null while snowflake defaults null to AUTO
## ==> specify compression at all times, even if it is AUTO

resource "snowflake_file_format" "rs_migration" {
  provider    = snowflake.admin_system
  name        = "RS_MIGRATION_CSV"
  database    = snowflake_schema.schema["MAIN"].database
  schema      = snowflake_schema.schema["MAIN"].name
  format_type = "CSV"

  field_delimiter              = "\t"
  record_delimiter             = "\n"
  timestamp_format             = "YYYY-MM-DD HH24:MI:SS.FF9"
  field_optionally_enclosed_by = "\""
  null_if                      = []
  compression                  = "gzip"
  binary_format                = "HEX"
  escape                       = " "
  escape_unenclosed_field      = "\\"
  encoding                     = "UTF8"
}

resource "snowflake_file_format" "marketing_costs" {
  provider    = snowflake.admin_system
  for_each    = snowflake_database.db # create this file format in all databases
  name        = "MARKETING_COSTS_UNLOAD"
  database    = each.key
  schema      = "PUBLIC"
  format_type = "PARQUET"

  compression    = "AUTO"
  null_if        = []
  binary_as_text = false
}

resource "snowflake_file_format" "snowplow_json" {
  provider    = snowflake.admin_system
  comment     = "File format used to unload Snowplow data"
  name        = "SNOWPLOW_ENRICHED_JSON"
  database    = snowflake_database.snowplow.name
  schema      = "PUBLIC"
  format_type = "JSON"

  null_if       = []
  compression   = "AUTO"
  binary_format = "HEX"
}