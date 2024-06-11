#!/bin/bash
set -e

# Cambia la contraseña del usuario postgres
psql -v ON_ERROR_STOP=1 --username "postgres" <<-EOSQL
    ALTER USER postgres WITH PASSWORD 'mysecretpassword';
EOSQL
