resource "snowflake_stage" "stage" {
  provider            = snowflake.admin_system
  name                = upper("${var.shared.project_code}_${var.shared.region_code}_stage_${terraform.workspace}")
  url                 = "s3://${var.shared.project_code}-${var.shared.region_code}-snowplow-s3-integration/test"
  database            = snowflake_schema.schema_external_tables.database
  schema              = snowflake_schema.schema_external_tables.name
  storage_integration = snowflake_storage_integration.integration.name
}

# external stages ownership is preserved since schema_external_tables is a managed schema
# you can still grant usage, but only as the owner of the schema
resource "snowflake_stage_grant" "grant_example_stage_usage" {
  provider = snowflake.admin_system

  database_name = snowflake_database.snowplow.name
  schema_name   = snowflake_schema.schema_external_tables.name
  roles         = ["INGESTER", "TRANSFORMER"]
  privilege     = "USAGE"
  stage_name    = snowflake_stage.stage.name

  with_grant_option = false
}

## After loading the example file to S3 (you can do so manually)
## and running apply on this module, you can select in Snowflake console:
#select $1,
#       $2,
#       $3,
#       $7,
#       $11,
#       $14,
#       $19
#from @<project_code>_<region_code>_STAGE_DEFAULT/datapaper_anonymized.csv.gz;