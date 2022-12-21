locals {
  base_schemas = {
    "DERIVED" = {
      database = "STAGE"
      comment  = "contains raw data from our source systems"
    }
    "MAIN" = {
      database = "STAGE"
      comment  = "contains tables and views accessible to analysts"
    }
    "REPORTING" = {
      database = "STAGE"
      comment  = "contains tables and views accessible for reporting"
    }
  }
}

resource "snowflake_schema" "schema" {
  for_each   = local.base_schemas
  database   = each.value.database
  name       = each.key
  is_managed = false

  depends_on = [snowflake_database.db]
}

resource "snowflake_schema" "tagging_schema" {
  provider = snowflake.admin_system

  for_each = snowflake_database.db # create this schema in all databases
  database = each.key
  name     = "TAG_SCHEMA"
  comment  = "This is a test schema to contain tagging objects"

  is_transient        = false
  is_managed          = true
  data_retention_days = 0 # disables Time Travel for the specified object
}

resource "snowflake_schema" "marketing_unique" {
  provider = snowflake.admin_system

  database = "STAGE"
  name     = "MARKETING_FAIRY"

  is_transient        = false
  is_managed          = true
  data_retention_days = 0 # disables Time Travel for the specified object
}

resource "snowflake_schema" "airbyte_landing" {
  provider = snowflake.admin_system

  database = snowflake_database.airbyte.name
  name     = "AIRBYTE_LANDING"
  is_transient        = false
  is_managed          = true
  data_retention_days = 0 # disables Time Travel for the specified object
}

resource "snowflake_tag_association" "schema_association" {
  object_identifier {
    name = snowflake_schema.marketing_unique.name
    database = snowflake_schema.marketing_unique.database
  }
  object_type = "SCHEMA"
  tag_id      = snowflake_tag.mapping.id
  tag_value   = "marketing"
}

// Snowflake DDL
resource "snowflake_schema" "schema_external_tables" {
  database = snowflake_database.snowplow.id
  name     = upper("${var.shared.project_code}_${var.shared.region_code}_raw_${terraform.workspace}")
  comment  = "Schema for external tables"

  is_transient = false
  is_managed   = false
}