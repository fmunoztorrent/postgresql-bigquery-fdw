-- Habilita la extensión plpython3u
CREATE EXTENSION IF NOT EXISTS plpython3u;

-- Define la función en PL/Python
CREATE OR REPLACE FUNCTION query_bigquery(query TEXT)
RETURNS JSON AS $$
import os
import json
from google.auth import default
from google.auth.transport.requests import Request
from google.oauth2 import service_account
from google.cloud import bigquery

def query_bigquery(query):
    # Establecer la variable de entorno para las credenciales de Google Cloud
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/etc/gcloud/credentials.json"

    # Configura el alcance para BigQuery
    SCOPES = ["https://www.googleapis.com/auth/cloud-platform"]

    # Autenticación con Google Cloud
    credentials = service_account.Credentials.from_service_account_file(
        os.environ["GOOGLE_APPLICATION_CREDENTIALS"], scopes=SCOPES
    )

    # Cliente de BigQuery
    client = bigquery.Client(credentials=credentials, project=credentials.project_id)

    # Ejecuta la consulta
    query_job = client.query(query)
    results = query_job.result()

    # Convierte los resultados a JSON
    rows = [dict(row) for row in results]
    return json.dumps(rows)

return query_bigquery(query)
$$ LANGUAGE plpython3u;
