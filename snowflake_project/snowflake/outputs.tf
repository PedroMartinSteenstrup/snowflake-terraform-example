output "snowflake_svc_public_key" {
    value = tls_private_key.svc_key.public_key_pem
    sensitive = true
}
output "snowflake_svc_private_key" {
    value = tls_private_key.svc_key.private_key_pem
    sensitive = true
}

output "snowflake_storage_integration_id" {
  value  = snowflake_storage_integration.integration.id
}

output "storage_aws_external_id" {
  value  = snowflake_storage_integration.integration.storage_aws_external_id
}

output "storage_aws_iam_user_arn" {
  value  = snowflake_storage_integration.integration.storage_aws_iam_user_arn
}