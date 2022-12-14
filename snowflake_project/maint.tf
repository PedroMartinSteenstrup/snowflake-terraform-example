# This top level file is here for convenience
locals {
  shared = {
    aws_profile           = var.aws_profile
    aws_region            = var.aws_region
    project_code          = var.project_code
    region_code           = var.region_code
    aws_account_id        = var.aws_account_id
    managed_by            = var.managed_by
    snowflake_account_arn = var.snowflake_account_arn
    snowflake_external_id = var.snowflake_external_id
  }
}

module "aws-s3" {
  # this is used to generate a bucket we create an external table from
  source = "./aws/eu-west-2/s3"
  shared = local.shared
}

module "snowflake" {
  # this is our main snowflake module
  source = "./snowflake"
  shared = local.shared
}