import os
import json
from google.auth import default
from google.auth.transport.requests import Request
from google.cloud import bigquery

def query_bigquery(query):
    # Autenticación con Google Cloud
    credentials, project = default()
    credentials.refresh(Request())

    # Cliente de BigQuery
    client = bigquery.Client(credentials=credentials, project=project)

    # Ejecuta la consulta
    query_job = client.query(query)
    results = query_job.result()

    # Convierte los resultados a JSON
    rows = [dict(row) for row in results]
    return json.dumps(rows)
