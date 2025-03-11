-- lesson 02 engines
CREATE TABLE IF NOT EXISTS inventory1
(
    `id` Int32,
    `status` String,
    `price` String,
    `comment` String
)
ENGINE = MergeTree
PRIMARY KEY (id, price)
ORDER BY (id, price, status);

INSERT INTO inventory1 VALUES (23, 'success', '1000', 'Confirmed');
INSERT INTO inventory1 VALUES (23, 'success', '2000', 'Cancelled'); 
SELECT * from inventory1 WHERE id=23;

CREATE TABLE IF NOT EXISTS inventory2
(
    `id` Int32,
    `status` String,
    `price` String,
    `comment` String
)
ENGINE = ReplacingMergeTree
PRIMARY KEY (id)
ORDER BY (id, status);

INSERT INTO inventory2 VALUES (23, 'success', '1000', 'Confirmed');
INSERT INTO inventory2 VALUES (23, 'success', '2000', 'Cancelled'); 
SELECT * from inventory2 WHERE id=23;

CREATE TABLE IF NOT EXISTS inventory3
(
    `id` Int32,
    `status` String,
    `price` String,
    `comment` String,
    `sign` Int8
)
ENGINE = CollapsingMergeTree(sign)
PRIMARY KEY (id)
ORDER BY (id, status);

INSERT INTO inventory3 VALUES (23, 'success', '1000', 'Confirmed', 1);
INSERT INTO inventory3 VALUES (23, 'success', '2000', 'Cancelled', -1); 
SELECT * from inventory3 WHERE id=23;

CREATE TABLE IF NOT EXISTS inventory4
 (
    `id` Int32,
    `status` String,
    `price` Int32,
    `num_items` UInt64
) 
ENGINE = MergeTree 
ORDER BY (id, status);  

CREATE MATERIALIZED VIEW IF NOT EXISTS agg_inventory
(
    `id` Int32,
    `max_price` AggregateFunction(max, Int32),
    `sum_items` AggregateFunction(sum, UInt64)
)
ENGINE = AggregatingMergeTree() 
ORDER BY (id)
AS SELECT
    id,
    maxState(price) as max_price,
    sumState(num_items) as sum_items
FROM inventory4
GROUP BY id;

INSERT INTO inventory4 VALUES (3, 100, 2), (3, 500, 4);

SELECT 
  id, 
  maxMerge(max_price) AS max_price, 
  sumMerge(sum_items) AS sum_items 
FROM agg_inventory 
WHERE id=3 
GROUP BY id;


CREATE TABLE log_location
(
  id Int32,
  long String,
  lat Int32
) ENGINE = TinyLog;



CREATE TABLE mysql_inventory
(
  id Int32,
  price Int32
)
ENGINE = MySQL('host:port', 'database', 'table', 'user', 'password')
