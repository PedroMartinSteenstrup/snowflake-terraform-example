terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.53"
    }
  }
}

variable "shared" {
  type = object({
    # If not specified, will discard any others.
    project_code   = string
    region_code    = string
    aws_profile    = string
    aws_account_id = string
    managed_by     = string
    #    snowflake_account_arn = string
    #    snowflake_external_id = string
  })
}

# ACCOUNTADMIN is only for initial setup tasks and managing account-level objects

provider "snowflake" {
  # privileges to create warehouses and databases (and other objects) in an account
  alias = "admin_system"
  role  = "SYSADMIN"
}

provider "snowflake" {
  # manage any object grant globally, as well as create, monitor, and manage users and roles
  alias = "admin_security"
  role  = "SECURITYADMIN"
}

provider "snowflake" {
  # privileges to create warehouses and databases (and other objects) in an account
  alias = "admin_warehouse"
  role  = "SYSADMIN"
}

provider "snowflake" {
  # a user administrator dedicated to user and role management only
  alias = "admin_user"
  role  = "USERADMIN"
}

resource "tls_private_key" "svc_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
