# Snowflake - Terraform example

## Get a Snowflake Trial account

https://docs.snowflake.com/en/user-guide/admin-trial-account.html

## Install terraform

https://developer.hashicorp.com/terraform/downloads

```shell
brew tap hashicorp/tap
```
```shell
brew install hashicorp/tap/terraform
```

This guide was made with `Terraform v1.3.6`.

If this is different from your current, you can use `tfswitch` to conveniently go from one version to another: https://tfswitch.warrensbox.com/

## Install Terragrunt

```shell
brew install terragrunt
```

## Setup Terraform

This guidance is here purely for convenience, it is likely to go out of date, and when in doubt, [check out the provider page](https://github.com/Snowflake-Labs/terraform-provider-snowflake).

### Locally (MacOS)

Generate a new key (skip if you are using password authentication to Snowflake).

See file [provisioning_user_rsa.sh](provisioning/provisioning_user_rsa.sh)

Then add necessary config to ~/.zshrc, or export.

See file [.snow.env](provisioning/.snow.env)

### In Snowflake 

see file [provisioning_user_sf.sql](provisioning/provisioning_user_sf.sql)
