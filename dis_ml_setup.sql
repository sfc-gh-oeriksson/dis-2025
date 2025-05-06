USE ROLE ACCOUNTADMIN;
CREATE OR REPLACE WAREHOUSE ML_HOL_WH; --by default, this creates an XS Standard Warehouse
USE DATABASE ML_HOL_DB;
USE SCHEMA ML_HOL_SCHEMA;
CREATE OR REPLACE STAGE ML_HOL_ASSETS; --to store model assets

-- create csv format
CREATE FILE FORMAT IF NOT EXISTS ML_HOL_DB.ML_HOL_SCHEMA.CSVFORMAT 
    SKIP_HEADER = 1 
    TYPE = 'CSV';

-- create external stage with the csv format to stage the diamonds dataset
CREATE STAGE IF NOT EXISTS ML_HOL_DB.ML_HOL_SCHEMA.DIAMONDS_ASSETS 
    FILE_FORMAT = ML_HOL_DB.ML_HOL_SCHEMA.CSVFORMAT 
    URL = 's3://sfquickstarts/intro-to-machine-learning-with-snowpark-ml-for-python/diamonds.csv';
    -- https://sfquickstarts.s3.us-west-1.amazonaws.com/intro-to-machine-learning-with-snowpark-ml-for-python/diamonds.csv

-- Create Notebook
CREATE OR REPLACE NOTEBOOK ML_HOL_DB.ML_HOL_SCHEMA.ML_HOL_DEMO_NOTEBOOK 
FROM '@ML_HOL_DB.ML_HOL_SCHEMA.GITHUB_INTEGRATION_SNOWFLAKE_ML_HOL/branches/main/' 
MAIN_FILE = 'GETTING_STARTED_WITH_ML.ipynb'
QUERY_WAREHOUSE = 'ML_HOL_WH';

ALTER NOTEBOOK ML_HOL_DB.ML_HOL_SCHEMA.ML_HOL_DEMO_NOTEBOOK ADD LIVE VERSION FROM LAST;

-- Provide link to notebook
SELECT 'Visit the demo notebook here: ' AS DEMO_INSTRUCTIONS
UNION ALL
SELECT CONCAT_WS('/', 'https://app.snowflake.com',CURRENT_ORGANIZATION_NAME(), CURRENT_ACCOUNT_NAME(), '#/notebooks/ML_HOL_DB.ML_HOL_SCHEMA.ML_HOL_DEMO_NOTEBOOK') AS DEMO_INSTRUCTIONS;
