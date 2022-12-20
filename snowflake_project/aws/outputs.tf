output "s3_bucket_arn" {
  value = module.s3.s3_bucket_arn
}

output "s3_bucket_id" {
  value = module.s3.s3_bucket_id
}

output "snowflake_role_arn" {
  value = module.roles.snowflake_role_arn
}