#!/bin/bash

set -e

# plugin pg_stat_statements

cat >> ${PGDATA}/postgresql.conf <<EOF

shared_preload_libraries = 'pg_stat_statements'
pg_stat_statements.max = 10000
pg_stat_statements.track = all

EOF
# pg stat

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION pg_stat_statements;
EOSQL

