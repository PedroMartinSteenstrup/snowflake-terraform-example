resource "snowflake_warehouse" "warehouse_admin" {
  provider       = snowflake.admin_warehouse
  name           = "ADMINISTRATING"
  warehouse_size = "xsmall"
  scaling_policy = "ECONOMY"
  auto_suspend   = 60
}

resource "snowflake_warehouse" "warehouse_ingest" {
  provider          = snowflake.admin_warehouse
  name              = "INGEST"
  warehouse_size    = "xsmall"
  auto_suspend      = 60
  max_cluster_count = 3
}

resource "snowflake_warehouse" "warehouse_transform" {
  provider       = snowflake.admin_warehouse
  name           = "TRANSFORM"
  warehouse_size = "xsmall"
  auto_suspend   = 60
}

resource "snowflake_warehouse" "warehouse_serve" {
  provider                  = snowflake.admin_warehouse
  name                      = "SERVE"
  warehouse_size            = "xsmall"
  auto_suspend              = 60
  enable_query_acceleration = true
}
