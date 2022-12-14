terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "shared" {
  type = object({
    # If not specified, will discard any others.
    project_code  = string
    region_code = string
    aws_profile = string
  })
}

resource "aws_s3_bucket" "snowflake-landing-example" {
  bucket = "${var.shared.project_code}-${var.shared.region_code}-snowflake-landing-example"
}

resource "aws_s3_bucket_versioning" "snowflake-landing-example" {
  bucket = aws_s3_bucket.snowflake-landing-example.id
  versioning_configuration {
    status = "Disabled"
  }
}