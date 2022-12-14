terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_s3_bucket" "snowflake-landing-example" {
  bucket = "snowflake-landing-example"
}

resource "aws_s3_bucket_versioning" "snowflake-landing-example" {
  bucket = aws_s3_bucket.snowflake-landing-example.id
  versioning_configuration {
    status = "Disabled"
  }
}