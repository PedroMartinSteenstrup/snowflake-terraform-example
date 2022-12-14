# Snowflake - Terraform example

## Get Trial accounts

### Snowflake 

Snowflake gives some credit for whoever wishes to tinker with it, and given what we'll set up, it is unlikely to ever reach billing.

https://docs.snowflake.com/en/user-guide/admin-trial-account.html

### Amazon

We'll create a few AWS resources, again nothing likely to go over the free tier allowance.

https://aws.amazon.com/free/

If you have an existing account, then make sure the IAM role you'll enter has the permissions to work with S3 buckets. 
If you have never worked with aws & you're not interested, you can
- Comment out all code related to external tables and storage integration in Snowflake
- Or create a free tier and use root keys (no restrictions) 

## Installs

### Terraform

https://developer.hashicorp.com/terraform/downloads

```shell
brew tap hashicorp/tap
```
```shell
brew install hashicorp/tap/terraform
```

This guide was made with `Terraform v1.3.6`.

### Tfswitch

If this guide is using a different version of terraform than your current deployment, you can use `tfswitch` to conveniently go from one version to another: 

https://tfswitch.warrensbox.com/

### Terragrunt

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



# FAQ 

### **Import an existing resource**

You can test imports by creating manually a Snowflake user in the console. Remember to use the right admin user (the same one that terraform will use to manage users).

![create_user](./resources/screenshots/manual_create_user.png)

Then it requires creating the relevant configuration first in Terraform:
```shell
resource "snowflake_user" "test_import_user" {
  provider             = snowflake.admin_security
  # more properties of the user you created
}
```
then it can be imported and placed under terraform management
```shell
terraform import module.snowflake.snowflake_user.test_import_user NAME_OF_USER_IN_SNOWFLAKE
```
<br>

### **Generate a graph for documentation**
```shell
cd snowflake_project
terraform graph | dot -Tsvg > ../resources/graph.svg
```
![terraform_graph](./resources/graph.svg)
<br>

### **Gotchas**

1. There is no remote backend defined, because this is a playground.
2. It expects a terraform.tfvars file at the root of `terraform` folder to store the few variables reused in the project that have nothing to do with the infrastructure itself. You can find an example file with the necessary variables [here](resources/files/terraform.tfvars.example)

<br>

### **Datasets origin**

[datapaper_anonymized.csv.gz](./resources/files/), Ederer, Florian, and Fr??d??ric Schneider. ???Trust and Promises over Time.??? American Economic Journal: Microeconomics 14, no. 3 (August 2022): 304???20. https://doi.org/10.1257/mic.20200049.