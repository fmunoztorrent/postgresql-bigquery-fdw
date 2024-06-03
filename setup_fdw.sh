#!/bin/bash
set -e

# Define foreign tables in PostgreSQL to access BigQuery data
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE FOREIGN TABLE bigquery_table (
        column1 TYPE,
        column2 TYPE
    )
    SERVER bigquery_srv
    OPTIONS (
        project 'your-gcp-project-id',
        dataset 'your-dataset-id',
        table 'your-bigquery-table-name'
    );
EOSQL
