#!/bin/bash

before="$(date +%s)"

DATA_FILE=$1
DB_NAME=$2
DB_HOST=localhost
DB_USER=songpon
CNAME="pgmaster"
PSQL="docker exec -i $CNAME psql"
DROPDB="docker exec -it $CNAME dropdb"
CREATEDB="docker exec -it $CNAME createdb"

echo 1.Kill current connection

$PSQL -h $DB_HOST -U $DB_USER postgres -c "SELECT
    pg_terminate_backend(pid)
FROM
    pg_stat_activity
WHERE
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname in ('$DB_NAME')
    ;"
echo droping database
$DROPDB -h $DB_HOST -U $DB_USER $DB_NAME

echo create database
$CREATEDB -h $DB_HOST -U $DB_USER $DB_NAME

echo restoring
gunzip -c $DATA_FILE| $PSQL -q -h $DB_HOST -U $DB_USER $DB_NAME

after="$(date +%s)"
elapsed_seconds="$(expr $after - $before)"

echo 
echo Restore Time Elapsed : $elapsed_seconds sec
