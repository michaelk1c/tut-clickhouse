-- Query 8: Insert with partitioning
-- INSERT INTO FUNCTION s3(
--     'https://storage.googleapis.com/grey-rhino-trading-system-lunar/input/v1.0.1/clickouse_write_test1.parquet',
--     'Parquet'
-- )
-- PARTITION BY rand() % 10
-- SELECT *
-- FROM s3(
--     'https://storage.googleapis.com/grey-rhino-trading-system-lunar/input/v1.0.1/yfinance_balance_sheets_vti_20241107.parquet',
--     'Parquet'
-- )
-- LIMIT 100000;