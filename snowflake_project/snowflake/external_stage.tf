// Snowflake DDL
resource "snowflake_schema" "schema_external_tables" {
  database = snowflake_database.snowplow.id
  name     = upper("${var.shared.project_code}_${var.shared.region_code}_raw_${terraform.workspace}")
  comment  = "Schema for external tables"

  is_transient = false
  is_managed   = false
}

resource "snowflake_stage" "stage" {
  name                = upper("${var.shared.project_code}_${var.shared.region_code}_stage_${terraform.workspace}")
  url                 = "s3://${var.shared.project_code}-${var.shared.region_code}-snowplow-s3-integration/test"
  database            = snowflake_database.snowplow.name
  schema              = snowflake_schema.schema_external_tables.name
  storage_integration = snowflake_storage_integration.integration.name
}