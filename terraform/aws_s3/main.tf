terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_s3_bucket" "snowflake_landing" {
  bucket        = "${var.shared.project_code}-${var.shared.region_code}-snowplow-s3-integration"
  force_destroy = true
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

resource "aws_s3_object" "upload_external_stage_file" {
  bucket = aws_s3_bucket.snowflake_landing.id
  key      = "test/datapaper_anonymized.csv.gz"
  source   = "${path.root}/../resources/files/datapaper_anonymized.csv.gz"
  etag     = filemd5("${path.root}/../resources/files/datapaper_anonymized.csv.gz")
}