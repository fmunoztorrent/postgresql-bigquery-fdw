# PostgreSQL to BigQuery FDW Setup

This repository contains the necessary configuration and scripts to connect PostgreSQL to BigQuery using Foreign Data Wrappers (FDW). The setup is containerized using Docker to avoid installing software directly on your local machine.

## Prerequisites

- Docker
- Docker Compose
- Google Cloud Platform (GCP) credentials file (JSON format)

## Setup Instructions

1. **Place your GCP credentials file:**

    Ensure your GCP credentials file is located at `./path/to/credentials.json`.

2. **Build and start the Docker container:**

    ```bash
    make all
    ```

    This command will:
    - Build the Docker image
    - Start the Docker container
    - Initialize the database and configure FDW

## Makefile Commands

- **Build the Docker image:**

    ```bash
    make build
    ```

- **Start the Docker container:**

    ```bash
    make up
    ```

- **Stop the Docker container:**

    ```bash
    make down
    ```

- **Restart the Docker container:**

    ```bash
    make restart
    ```

- **Initialize the database:**

    ```bash
    make init-db
    ```

- **Setup FDW:**

    ```bash
    make setup-fdw
    ```

- **Execute the entire process:**

    ```bash
    make all
    ```

## Environment Variables

- `GOOGLE_APPLICATION_CREDENTIALS`: Path to the GCP credentials file.

## Directory Structure

- `Dockerfile`: Dockerfile to build the PostgreSQL image with necessary extensions.
- `docker-compose.yml`: Docker Compose file to manage the container.
- `init-db.sh`: Script to initialize the database and configure FDW.
- `setup_fdw.sh`: Script to setup the foreign data wrapper.
- `Makefile`: Makefile to automate Docker commands.
- `credentials.json`: GCP credentials file (not included, place your own file here).

## Notes

- Ensure the paths in the scripts and Dockerfile match the actual location of your credentials file.
- Modify the `setup_fdw.sh` script to define the foreign tables based on your BigQuery schema.
