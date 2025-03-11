-- lesson 03

CREATE TABLE IF NOT EXISTS default.projects1
(
   `project_id` UInt32,
   `name` String,
   `created_date` Date
)
ENGINE = MergeTree
ORDER BY (project_id, created_date);


INSERT INTO projects1
SELECT * FROM generateRandom('project_id Int32, name String, created_date Date', 10, 10, 1)
LIMIT 10000000;

SELECT * FROM projects1 LIMIT 10 FORMAT Pretty;

EXPLAIN indexes=1
SELECT * FROM projects1 WHERE created_date=today();

-- order key
CREATE TABLE IF NOT EXISTS default.projects2
(
    `project_id` UInt32,
    `name` String,
    `created_date` Date
)
ENGINE = MergeTree
PRIMARY KEY (created_date, project_id)
ORDER BY (created_date, project_id, name);

INSERT INTO projects2
SELECT * FROM generateRandom('project_id Int32, name String, created_date Date', 10, 10, 1)
LIMIT 10000000;

SELECT
    name,
    partition
FROM
    system.parts
WHERE
    table = 'projects2'
FORMAT Pretty;

-- partitioned
CREATE TABLE IF NOT EXISTS default.projects_partitioned
(
    `project_id` UInt32,
    `name` String,
    `created_date` Date
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(created_date)
PRIMARY KEY (created_date, project_id)
ORDER BY (created_date, project_id, name);

INSERT INTO projects_partitioned
SELECT * FROM generateRandom('project_id Int32, name String, created_date Date', 10, 10, 1)
LIMIT 100;

SELECT * 
FROM projects_partitioned 
WHERE created_date='2020-02-01'
FORMAT Pretty;

EXPLAIN indexes=1
SELECT * FROM projects_partitioned 
WHERE created_date='2020-02-01';
