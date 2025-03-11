-- Query 1: Select all data with schema definition
SELECT * 
FROM s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/backtest_data/polygon_io_minute_aggs_hive_partitioned_parquet/year%3D2014/month%3D1/date%3D2014-01-02/00000000.parquet',
    'Parquet',
    'symbol String,
    timestamp DateTime64(9),
    open Float64,
    high Float64,
    low Float64,
    close Float64,
    volume Int64,
    vwap Float64,
    transactions Int64'
);

-- Query 2: Simple select all
SELECT * 
FROM s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/backtest_data/polygon_io_minute_aggs_hive_partitioned_parquet/year%3D2014/month%3D1/date%3D2014-01-02/00000000.parquet',
    'Parquet'
);

-- Query 3: Select with volume filter and ordering
SELECT * 
FROM s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/backtest_data/polygon_io_minute_aggs_hive_partitioned_parquet/year%3D2014/month%3D1/date%3D2014-01-02/00000000.parquet',
    'Parquet'
) 
WHERE volume > 10000 
ORDER BY volume DESC;

-- Query 4: Select from balance sheets
SELECT * 
FROM s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/input/v1.0.1/yfinance_balance_sheets_vti_20241107.parquet',
    'Parquet'
);

-- Query 5: Describe balance sheets table
DESCRIBE TABLE s3(
    'https://storage.googleapis.com/grey-rhino-trading-system-lunar/input/v1.0.1/yfinance_balance_sheets_vti_20241107.parquet'
);
