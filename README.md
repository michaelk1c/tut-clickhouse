# Clickhouse

## 1. Install

### 1.1 Use docker compose

- see the compose file in onec-devops3

### 1.2. Install client

#### 1.2.1 Mac

```
brew install clickhouse
```

## 2. Running SQL query

1. set up .env file with direnv
2. use config file
3. call client with -c option to config file

```
clickhouse client -c config.xml
```

This will bring you to the sql command line

### 2.1 To run the sql file from the file system

1. Write a sql file
2. Run this command to connect, execute and show the result

```
clickhouse client -c config.xml --queries-file lesson02.sql --echo
```
