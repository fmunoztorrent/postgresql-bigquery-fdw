#!/bin/bash
set -e

# Create extension and configure FDW using environment variables
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION multicorn;
    CREATE SERVER bigquery_srv
    FOREIGN DATA WRAPPER multicorn
    OPTIONS (
        wrapper 'multicorn.google_bigqueryfdw.BigQueryFdw'
    );

    CREATE USER MAPPING FOR $POSTGRES_USER
    SERVER bigquery_srv
    OPTIONS (
        service_account_keyfile '$GOOGLE_APPLICATION_CREDENTIALS'
    );
EOSQL
