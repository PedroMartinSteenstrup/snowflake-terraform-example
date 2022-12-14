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
    project_code  = string
    region_code = string
  })
}

provider "snowflake" {
  alias = "admin_system"
  role  = "SYSADMIN"
}

provider "snowflake" {
  alias = "admin_security"
  role  = "SECURITYADMIN"
}

provider "snowflake" {
  alias = "admin_warehouse"
  role  = "SYSADMIN"
}

provider "snowflake" {
  alias = "admin_user"
  role  = "USERADMIN"
}

resource "tls_private_key" "svc_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
