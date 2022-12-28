terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

// Template file for Snowflake to assume the AWS role
// AWS Role with assume role policy
resource "aws_iam_role" "role_for_snowflake_load" {
  name               = "${var.shared.region_code}-snowflake-role-${terraform.workspace}"
  description        = "AWS role for Snowflake"
  assume_role_policy = templatefile("${path.root}/aws_policies/snowflake_load_trust_policy.json",
    {
      snowflake_account_arn = var.snowflake_account_arn
      snowflake_external_id = var.snowflake_external_id
    })
  tags = {
    Project   = upper(var.shared.project_code)
    ManagedBy = var.shared.managed_by
  }
}

#// Template file for Permission Policy. This allows read access to target S3 buckets
// Create a Policy with permission to read target S3 buckets using the policy template
resource "aws_iam_policy" "snowflake_load_policy" {
  name        = "${var.shared.region_code}-snowflake-access-${terraform.workspace}"
  description = "Allow authorised snowflake users to list files, read from S3 bucket."
  policy      = templatefile("${path.root}/aws_policies/snowflake_load_policy.json",
    {
      bucket_name = "${var.shared.project_code}-${var.shared.region_code}-snowplow-s3-integration"
    }
  )
}

// Attach the permission policy to the AWS Role
resource "aws_iam_role_policy_attachment" "role_for_snowflake_load_policy_attachment" {
  role       = aws_iam_role.role_for_snowflake_load.name
  policy_arn = aws_iam_policy.snowflake_load_policy.arn
}