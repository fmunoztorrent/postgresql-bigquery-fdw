FROM postgres:12

RUN apt-get update && apt-get install -y \
    postgresql-contrib \
    postgresql-server-dev-all \
    && pip install multicorn google-cloud-bigquery

# Copy the configuration file
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Set the environment variables for credentials
ENV GOOGLE_APPLICATION_CREDENTIALS=/path/to/credentials.json

# Copy the credentials file
COPY credentials.json /path/to/credentials.json

# Copy the initialization scripts
COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh
COPY setup_fdw.sh /docker-entrypoint-initdb.d/setup_fdw.sh
