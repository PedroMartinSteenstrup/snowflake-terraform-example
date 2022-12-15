#variable "mapping" {
#  type        = string
#  description = "some test value"
#
#  validation {
#    condition     = contains([
#      "data_platform", "commodity", "ds", "core", "panda", "strategic_products", "partner", "product", "marketing"
#    ], var.mapping)
#    error_message = "Valid values for mapping are (item1, item2, item3)."
#  }
#}

resource "snowflake_tag" "mapping" {
  provider = snowflake.admin_system

  name           = "mapping"
  database       = "STAGE"
  schema         = "TAG_SCHEMA"
  allowed_values = [
    "data_platform", "commodity", "ds", "core", "panda", "strategic_products", "partner", "product", "marketing"
  ]

  depends_on = [snowflake_schema.tagging_schema]
}