// Storage integration that assumes the AWS role created
resource "snowflake_storage_integration" "integration" {
  provider = snowflake.admin_system

  name                      = upper("${var.shared.project_code}_${var.shared.region_code}_SNOWPLOW_DE_HOMETOGO_PROD1_S3_INTEGRATION")
  comment                   = "Storage integration used to read files from S3 staging bucket"
  type                      = "EXTERNAL_STAGE"
  enabled                   = true
  storage_provider          = "S3"
  storage_aws_role_arn      = "arn:aws:iam::${var.shared.aws_account_id}:role/${var.shared.region_code}-snowflake-role-${terraform.workspace}"
  storage_allowed_locations = [
    "s3://${var.shared.project_code}-${var.shared.region_code}-snowplow-s3-integration/"
  ]
}