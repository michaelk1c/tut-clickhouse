CREATE TABLE inventory1
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

CREATE TABLE inventory2
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

CREATE TABLE inventory3
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
