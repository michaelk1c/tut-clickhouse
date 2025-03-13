-- Query 1: insert into parquet file
INSERT INTO FUNCTION s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/chtest/write_test1.parquet',
    'Parquet'
)
SELECT * FROM generateRandom('project_id Int32, name String, created_date Date', 10, 10, 1)
LIMIT 200;

INSERT INTO FUNCTION s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/chtest/write_test1.parquet',
    'Parquet'
)
SETTINGS s3_create_new_file_on_insert=1
--SETTINGS s3_create_new_file_on_insert=0, s3_truncate_on_insert=0
SELECT * FROM generateRandom('project_id Int32, name String, created_date Date', 10, 10, 1)
LIMIT 200;

-- describe table
DESCRIBE TABLE s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/chtest/write_test1.parquet'
);

-- select from parquet file
SELECT * 
FROM s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/chtest/write_test1.parquet',
    'Parquet'
)
LIMIT 20
FORMAT Pretty;

-- Reading from multiple parquet files in a directory
SELECT *
FROM s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/input/v1.0.1/sp500/financial_loss_output/v1/bi_losses_output/*.parquet',
    'Parquet')
LIMIT 20;
