USE ROLE ACCOUNTADMIN;

CREATE USER "tf-snow" RSA_PUBLIC_KEY='content-from-~/.ssh/snowflake_tf_snow_key.pub'
    DEFAULT_ROLE=PUBLIC MUST_CHANGE_PASSWORD=FALSE;

GRANT ROLE SYSADMIN TO USER "tf-snow";
GRANT ROLE SECURITYADMIN TO USER "tf-snow";

--# Run the following to find the YOUR_ACCOUNT_LOCATOR and your Snowflake Region ID values needed.
SELECT current_account() as YOUR_ACCOUNT_LOCATOR, current_region() as YOUR_SNOWFLAKE_REGION_ID;
-- the region ID is AWS_EU_WEST_2, so my terraform region is EU-WEST-2
