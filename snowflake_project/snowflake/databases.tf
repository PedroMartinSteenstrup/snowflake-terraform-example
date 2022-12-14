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
