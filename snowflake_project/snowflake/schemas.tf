#locals {
#  schemas = {
#    "DEV" = {
#      database = ""
#      comment  = "contains raw data from our source systems"
#    }
#    "STAGE" = {
#      database = ""
#      comment  = "contains tables and views accessible to analysts and reporting"
#    }
#    "PROD" = {
#      database = ""
#      comment  = "contains tables and views accessible to analysts and reporting"
#    }
#  }
#}
#
#resource "snowflake_schema" "schema" {
#  for_each = local.schemas
#  database   = each.key
#  name       = each.value.database
#  is_managed = false
#}