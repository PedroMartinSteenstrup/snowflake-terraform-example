variable "shared" {
  type = object({
    # If not specified, will discard any others.
    project_code          = string
    region_code           = string
    aws_profile           = string
    managed_by            = string
    aws_account_id        = string
  })
}

variable "snowflake_account_arn" {
  type = string
}

variable "snowflake_external_id" {
  type = string
}

