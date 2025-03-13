-- Query 1: insert into parquet file
INSERT INTO FUNCTION s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/chtest/write_test2.parquet',
    'Parquet'
)
SETTINGS s3_create_new_file_on_insert=1
PARTITION BY rand() % 10
SELECT * FROM generateRandom('project_id Int32, name String, created_date Date', 10, 10, 1)
LIMIT 20000;

-- Query 2: insert into parquet file
INSERT INTO FUNCTION s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/chtest/write_test2_{_partition_id}.parquet',
    'Parquet'
)
SETTINGS s3_create_new_file_on_insert=1
SELECT 
    *,
    rand() % 10 as _partition_id
FROM generateRandom('project_id Int32, name String, created_date Date', 10, 10, 1)
LIMIT 20000;

-- Query 3. Writing to multiple parquet files in a directory
INSERT INTO FUNCTION file('data_{_partition_id}.parquet', Parquet)
PARTITION BY toYYYYMM(created_date)
SELECT *
FROM generateRandom('project_id Int32, name String, created_date Date', 10, 10, 1)
LIMIT 10000;

-- Query 4. Writing to multple parquet files in a directory with file()
INSERT INTO FUNCTION file('foo_{_partition_id}.parquet', Parquet)
PARTITION BY concat(toString(toYear(created_date)), '_', toString(toMonth(created_date)))
SELECT 
    *,
    toString(toYear(created_date)) as year,
    toString(toMonth(created_date)) as month
FROM generateRandom('project_id Int32, name String, created_date Date', 10, 10, 1)
LIMIT 100;

--root@onec02:/var/lib/clickhouse/user_files# ll
-- total 192
-- drwxr-xr-x  2 clickhouse clickhouse   4096 Mar 14 07:05  ./
-- drwxrwxrwx 12 clickhouse clickhouse   4096 Mar  4 22:50  ../
-- -rw-r-----  1 clickhouse clickhouse 185478 Mar 14 07:05 'foo_(1,1).parquet'

-- Query 5. Writing to multiple parquet files in a directory with s3()
INSERT INTO FUNCTION s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/chtest/write_test3_{_partition_id}.parquet',
    Parquet)
PARTITION BY toYYYYMM(created_date)
SELECT *
FROM generateRandom('project_id Int32, name String, created_date Date', 10, 10, 1)
LIMIT 10000;

-- https://console.cloud.google.com/storage/browser/grey-rhino-trading-system-lunar/chtest;tab=objects?pageState=(%22StorageObjectListTable%22:(%22f%22:%22%255B%255D%22))&project=oc-lunar&prefix=&forceOnObjectsSortingFiltering=false
