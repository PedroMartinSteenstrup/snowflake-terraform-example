resource "snowflake_tag" "mapping" {
  provider = snowflake.admin_system

  name           = "mapping"
  database       = "STAGE"
  schema         = "TAG_SCHEMA"
  allowed_values = [
    "commodity", "core", "data_platform", "ds", "marketing", "panda", "partner", "product", "strategic_products"
  ]

  depends_on = [snowflake_schema.tagging_schema]
}