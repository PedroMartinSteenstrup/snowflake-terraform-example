USE ROLE ACCOUNTADMIN;

CREATE USER "tf-provisioning"
    RSA_PUBLIC_KEY = '<-- content-from-~/.ssh/snowflake_tf_snow_key.pub -->'
    DEFAULT_ROLE = PUBLIC -- default role is unprivileged
    MUST_CHANGE_PASSWORD = FALSE;


--create warehouses, databases, and all database objects
GRANT ROLE SYSADMIN TO USER "tf-provisioning";
-- to create the storage_integration
GRANT CREATE INTEGRATION ON ACCOUNT TO ROLE SYSADMIN;

-- global MANAGE GRANTS privilege to grant or revoke privileges on objects in the account
GRANT ROLE SECURITYADMIN TO USER "tf-provisioning";

-- Run the following to find the YOUR_ACCOUNT_LOCATOR and your Snowflake Region ID values needed.
SELECT current_account() as YOUR_ACCOUNT_LOCATOR, current_region() as YOUR_SNOWFLAKE_REGION_ID;
-- the region ID is AWS_EU_WEST_2, but correct terraform region is eu-west-2.aws, makes no sense
