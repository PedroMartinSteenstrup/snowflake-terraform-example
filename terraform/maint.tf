# This top level file is here for convenience
locals {
  shared = {
    aws_profile           = var.aws_profile
    aws_region            = var.aws_region
    project_code          = var.project_code
    region_code           = var.region_code
    aws_account_id        = var.aws_account_id
    managed_by            = var.managed_by
  }
}

module "aws-s3" {
  # this is used to generate a bucket we create the external table from
  source = "./aws_s3"
  shared = local.shared
  snowflake_account_arn = module.snowflake.storage_aws_iam_user_arn
  snowflake_external_id = module.snowflake.storage_aws_external_id
}

module "aws-roles" {
  # this is used to generate a bucket we create the external table from
  source = "./aws_roles"
  shared = local.shared
  snowflake_account_arn = module.snowflake.storage_aws_iam_user_arn
  snowflake_external_id = module.snowflake.storage_aws_external_id
}

module "snowflake" {
  # this is our main snowflake module
  source = "./snowflake"
  shared = local.shared
}