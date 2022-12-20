resource "aws_s3_bucket" "snowflake_landing" {
  bucket = "${var.shared.project_code}-${var.shared.region_code}-snowplow-s3-integration"
}

resource "aws_s3_bucket_acl" "snowflake-landing-example" {
  bucket = aws_s3_bucket.snowflake_landing.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "snowflake-landing-example" {
  bucket = aws_s3_bucket.snowflake_landing.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "stage_bucket_load_access_block" {
  bucket                  = aws_s3_bucket.snowflake_landing.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}