terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.53"
    }
  }
}

module "aws-s3" {
    source = "../aws/eu-west-2/s3"
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
