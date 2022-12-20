output "snowflake_role_arn" {
  value = aws_iam_role.role_for_snowflake_load.arn
}