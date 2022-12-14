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
