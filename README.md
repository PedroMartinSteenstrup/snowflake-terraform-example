# sfguide-terraform-sample

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

## Setup Terraform

### Locally (MacOS)

Generate a new key (skip if you are using password authentication to Snowflake).

See file [provisioning_user_rsa.sh](provisioning/provisioning_user_rsa.sh)

Then add necessary config to ~/.zshrc, or export.

See file [.snow.env](provisioning/.snow.env)

### In Snowflake 

see file [provisioning_user_sf.sql](provisioning/provisioning_user_sf.sql)
