output "s3_bucket_arn" {
  value = aws_s3_bucket.snowflake_landing.arn
}

output "s3_bucket_id" {
  value = aws_s3_bucket.snowflake_landing.id
}
