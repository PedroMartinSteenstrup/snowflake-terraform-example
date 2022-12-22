terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "shared" {
  type = object({
    # If not specified, will discard any others.
    project_code   = string
    region_code    = string
    aws_profile    = string
    managed_by     = string
    aws_account_id = string
  })
}

variable "snowflake_account_arn" {
  type = string
}

variable "snowflake_external_id" {
  type = string
}

# Configure the AWS Provider, credentials are source from $HOME/.aws/credentials
provider "aws" {
  region  = "eu-west-2"
  profile = var.shared.aws_profile
}

module "s3" {
  # this is our main snowflake module
  source = "./s3"
  shared = var.shared
}

module "roles" {
  # this is our main snowflake module
  source                = "./roles"
  shared                = var.shared
  snowflake_account_arn = var.snowflake_account_arn
  snowflake_external_id = var.snowflake_external_id
}