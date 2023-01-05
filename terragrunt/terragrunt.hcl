generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "snowflake" {
  region              = "${local.aws_region}"
  profile             = "${local.aws_profile}"
}
EOF
}

locals {
  account_vars      = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars       = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars  = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  organization_vars = {
    prefix = "htg"
  }

  account_id   = local.account_vars.locals.aws_account_id
  account_name = local.account_vars.locals.aws_account_name
  aws_profile  = local.account_vars.locals.aws_profile
  aws_region   = local.region_vars.locals.aws_region
  environment  = local.environment_vars.locals.environment
  repo_name    = "snowflake_terraform"
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
  local.organization_vars
)
