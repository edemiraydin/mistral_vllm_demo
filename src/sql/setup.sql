CREATE DATABASE MISTRAL_VLLM_DB;

USE DATABASE  MISTRAL_VLLM_DB;
USE WAREHOUSE COMPUTE_WH;

-- sample table with some product features
CREATE OR REPLACE TABLE product_info 
(id VARCHAR,
  name VARCHAR,
  feature_1 VARCHAR,
  feature_2 VARCHAR,
  feature_3 VARCHAR,
  specs VARIANT,
  target_customer1 VARCHAR,
  target_customer2 VARCHAR,
  target_customer3 VARCHAR)

  SELECT feature_1, feature_2, feature_3, target_customer1, target_customer2, target_customer3 FROM product_info 

  INSERT INTO PRODUCT_INFO SELECT 'A1234', 'EJOffice Standup Desk', 'ergonomic', 'affordable', 'made of wood', PARSE_JSON('{"weight": "33kg", "max_height": "1.5 m", "color": "wood"}'), 'remote office employees', 'sporty', 'male'
  
  INSERT INTO PRODUCT_INFO SELECT 'A3214', 'EJOffice Chair', 'ergonomic', 'adjustable', 'leather', PARSE_JSON('{"weight": "33kg", "max_height": "1.5 m", "color": "black"}'), 'remote office employees', 'business', 'male'

  INSERT INTO PRODUCT_INFO SELECT 'A3215', 'EJOffice Regular Desk', 'affordable', 'durable', 'metal', PARSE_JSON('{"weight": "33kg", "max_height": "1.5 m", "color": "black"}'), 'office employees', 'business', 'professional'

  INSERT INTO PRODUCT_INFO SELECT 'A3216', 'EJOffice Trash Wastebasket', 'luxury', 'natural', 'buffalo leather', PARSE_JSON('{"weight": "33kg", "max_height": "1.5 m", "color": "Cognac"}'), 'business executives', 'classy', 'professional'

  INSERT INTO PRODUCT_INFO SELECT 'A3217', 'EJOffice Paper Shredder', 'basic', 'durable', 'space efficient', PARSE_JSON('{"weight": "33kg", "max_height": "1.5 m", "color": "black"}'), 'office workers', 'practical', 'organized'


  
SHOW COMPUTE POOLS;

 -- create an image repo
CREATE IMAGE REPOSITORY MISTRAL_VLLM_DB.PUBLIC.IMAGES;
 
create stage yamls;
create stage if not exists files encryption = (type = 'SNOWFLAKE_SSE');

DROP SERVICE IF EXISTS mistral;
CREATE SERVICE  mistral
  IN COMPUTE POOL EJ_GPU_3_COMPUTE_POOL -- only 1 GPU needed for vllm
  FROM @YAMLS
  SPEC='spec.yaml'
  MIN_INSTANCES=1
  MAX_INSTANCES=1;

  CALL SYSTEM$GET_SERVICE_LOGS('MISTRAL_VLLM_DB.PUBLIC.MISTRAL', '0', 'vllm');
  CALL SYSTEM$GET_SERVICE_STATUS('MISTRAL_VLLM_DB.PUBLIC.MISTRAL', 100); 


-- let's get the endpoints vLLM and Jupyter
SHOW ENDPOINTS IN SERVICE MISTRAL;

