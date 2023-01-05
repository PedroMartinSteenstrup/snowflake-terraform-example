locals {
  roles = {
    "INGESTER" = {
      comment = "Owns the tables in raw schema"
    }
    "TRANSFORMER" = {
      comment = "Derived layers "
    }
  }
}

resource "snowflake_role" "role" {
  provider = snowflake.admin_user
  for_each = local.roles
  name     = each.key
  comment  = each.value.comment
}

resource "snowflake_role" "custom_role" {
  provider = snowflake.admin_user
  name     = "TEST_ROLE"
  comment  = "Testing direct grant"
}

resource "snowflake_role" "stage_ownership" {
  provider = snowflake.admin_user
  name     = "STAGE_ROLE"
  comment  = "Testing direct grant"
}