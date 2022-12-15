locals {
  databases = {
    "DEV" = {
      comment = "clone of stage"
    }
    "STAGE" = {
      comment = "dbt, derived"
    }
    "PROD" = {
      comment = "report tables"
    }
  }
}

resource "snowflake_database" "db" {
  for_each = local.databases
  name     = each.key
  comment  = each.value.comment
}

resource "snowflake_database" "airbyte" {
  name     = "AIRBYTE"
  comment  = "Landing database for all airbyte jobs"
}

resource "snowflake_database" "snowplow" {
  provider = snowflake.admin_system
  name     = "SNOWPLOW"
  comment  = "Landing database for all snowplow data"
}