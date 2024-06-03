# Docker container name
CONTAINER_NAME = postgres-bigquery

# Path to GCP credentials file
CREDENTIALS_PATH = ./path/to/credentials.json

# Command to build the Docker image
build:
	docker-compose build

# Command to start the Docker container
up:
	docker-compose up -d

# Command to stop the Docker container
down:
	docker-compose down

# Command to restart the Docker container
restart: down up

# Command to execute the initial setup script
init-db:
	docker exec -i $(CONTAINER_NAME) bash -c "/docker-entrypoint-initdb.d/init-db.sh"

# Command to execute the FDW setup script
setup-fdw:
	docker exec -i $(CONTAINER_NAME) bash -c "/docker-entrypoint-initdb.d/setup_fdw.sh"

# Command to execute the entire process
all: build up init-db setup-fdw
