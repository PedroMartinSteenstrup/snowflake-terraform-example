output "s3_bucket_arn" {
  value = module.aws-s3.s3_bucket_arn
}

output "s3_bucket_id" {
  value = module.aws-s3.s3_bucket_id
}

output "snowflake_role_arn" {
  value = module.aws-s3.snowflake_role_arn
}

output "storage_aws_external_id" {
  value  = module.snowflake.storage_aws_external_id
}

output "storage_aws_iam_user_arn" {
  value  = module.snowflake.storage_aws_iam_user_arn
}

output "external_stage" {
  value = module.snowflake.external_stage
}