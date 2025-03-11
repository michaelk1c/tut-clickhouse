CREATE DATABASE IF NOT EXISTS test;

CREATE TABLE IF NOT EXISTS test.orders
(`OrderID` Int64,
`CustomerID` Int64,
`OrderDate` DateTime,
`Comments` String,
`Cancelled` Bool)
ENGINE = MergeTree
PRIMARY KEY (OrderID, OrderDate)
ORDER BY (OrderID, OrderDate, CustomerID)
SETTINGS index_granularity = 8192;


INSERT INTO test.orders 
VALUES (334, 123, '2021-09-15 14:30:00', 'some comment', 
false);

SELECT OrderID, OrderDate FROM test.orders;

SELECT * FROM test.orders Pretty;

SHOW databases;

