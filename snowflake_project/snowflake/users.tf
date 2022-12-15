locals {
  defaults = {
    "data_analyst" = {
      role      = "TRANSFORMER",
      warehouse = snowflake_warehouse.warehouse_transform.name,
      namespace = "DEV.PUBLIC"
    }
    "data_engineer" = {
      role      = "INGESTER",
      warehouse = snowflake_warehouse.warehouse_transform.name,
      namespace = "DEV.PUBLIC"
    }
  }
}

variable "email" {
  type    = string
  default = "foo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^[0-9A-Za-z]+$", var.email))
    error_message = "For the email value only a-z, A-Z and 0-9 are allowed."
  }
}

resource "snowflake_user" "sf_tf_dummy_user" {
  provider             = snowflake.admin_security
  name                 = "dummy"
  email                = "dummy_dummy@company.com"
  default_warehouse    = local.defaults.data_analyst.warehouse
  default_role         = local.defaults.data_analyst.role
  default_namespace    = local.defaults.data_analyst.namespace
  must_change_password = true
}

resource "snowflake_user" "test_import_user" {
  # Used in FAQ section on importing existing resources
  provider             = snowflake.admin_user
  name                 = "dummy_import"
  email                = "dummy_import_dummy@company.com"
  default_warehouse    = local.defaults.data_analyst.warehouse
  default_role         = local.defaults.data_analyst.role
  default_namespace    = local.defaults.data_analyst.namespace
  must_change_password = true
}
