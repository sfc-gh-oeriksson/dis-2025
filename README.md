# dis-2025
In this repository there is material for the Snowflake workshop at Data Innovation Summit 2025.

Warm welcome!

## Get Started
If you don't have a Snowflake account, register for a free Snowflake Trial Account:
- [Free Snowflake Trial Account](https://signup.snowflake.com/)
- Please use **Enterprise Edition**
- Please use **AWS in US West (Oregon)**

Integrate this Github Repository with Snowflake by running the following SQL code in a Snowflake Worksheet:
```sql
USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE DATABASE ML_HOL_DB;
CREATE OR REPLACE SCHEMA ML_HOL_DB.ML_HOL_SCHEMA;
CREATE OR REPLACE WAREHOUSE ML_WH;

-- Create the integration with Github
CREATE OR REPLACE API INTEGRATION GITHUB_INTEGRATION_SNOWFLAKE_ML_HOL_DB
    api_provider = git_https_api
    api_allowed_prefixes = ('https://github.com/sfc-gh-oeriksson/')
    enabled = true
    comment='Oskars repository.';

-- Create the integration with the Github repository
CREATE GIT REPOSITORY GITHUB_INTEGRATION_SNOWFLAKE_ML_HOL
	ORIGIN = 'https://github.com/sfc-gh-oeriksson/dis-2025' 
	API_INTEGRATION = 'GITHUB_INTEGRATION_SNOWFLAKE_ML_HOL_DB' 
	COMMENT = 'Repository for DIS-2025 ML.';

-- Fetch most recent files from Github repository
ALTER GIT REPOSITORY GITHUB_INTEGRATION_SNOWFLAKE_ML_HOL FETCH;

-- Run the Setup Script
EXECUTE IMMEDIATE FROM @ML_HOL_DB.ML_HOL_SCHEMA.GITHUB_INTEGRATION_SNOWFLAKE_ML_HOL/branches/main/dis_ml_setup.sql;
