# PostgreSQL con integración a BigQuery

Este repositorio proporciona una configuración de Docker para un contenedor de PostgreSQL con la capacidad de ejecutar consultas en BigQuery utilizando credenciales de una cuenta de servicio de Google Cloud.

## Estructura del Proyecto

- **Dockerfile**: Define la imagen de Docker para PostgreSQL con las extensiones y configuraciones necesarias.
- **credentials.json**: Archivo de credenciales JSON para la cuenta de servicio de Google Cloud.
- **init.sql**: Script de SQL para configurar la extensión PL/Python y la función para consultar BigQuery.
- **requirements.txt**: Lista de bibliotecas de Python necesarias para la integración con Google Cloud.

## Prerrequisitos

1. Docker instalado en tu máquina.
2. Credenciales de cuenta de servicio de Google Cloud en formato JSON.

## Instrucciones

### 1. Clonar el repositorio

Clona este repositorio en tu máquina local:


### 1. Colocar las credenciales

Coloca tu archivo de credenciales JSON en el directorio raíz del proyecto con el nombre `credentials.json`.

### 2. Construir la imagen de Docker

Construye la imagen de Docker utilizando el `Dockerfile` proporcionado:

```sh
docker build -t pg_bigquery:latest .
```

### 3. Ejecutar el contenedor

Ejecuta un contenedor basado en la imagen construida:

```sh
docker run -d --name pg_bigquery -p 5432:5432 pg_bigquery:latest
```

### 4. Conectarse al contenedor

Conéctate al contenedor para verificar la configuración y realizar consultas:

```sh
docker exec -it pg_bigquery bash
```

### 5. Verificar la conexión a PostgreSQL

Dentro del contenedor, verifica la conexión a PostgreSQL:

```sh
psql -U postgres -W
```

### 6. Ejecutar consultas en BigQuery

Utiliza la función `query_bigquery` para ejecutar consultas en BigQuery desde PostgreSQL:

```sql
SELECT query_bigquery('SELECT * FROM your_table LIMIT 10');
```

## Notas

- Asegúrate de que el archivo `credentials.json` tenga los permisos adecuados para ser leído por el contenedor.
- La variable de entorno `GOOGLE_APPLICATION_CREDENTIALS` se configura en el `Dockerfile` para apuntar a `/etc/gcloud/credentials.json`.
- La función `query_bigquery` está definida en el archivo `init.sql` y utiliza PL/Python para interactuar con BigQuery.

## Problemas comunes

### Error de credenciales

Si encuentras un error relacionado con las credenciales, verifica que el archivo `credentials.json` esté correctamente ubicado y accesible dentro del contenedor.

### Error de permisos

Asegúrate de que el archivo `credentials.json` tenga los permisos adecuados para ser leído por PostgreSQL y Python dentro del contenedor.

---

Este repositorio proporciona una solución básica para integrar PostgreSQL con BigQuery utilizando Docker y PL/Python. Si tienes alguna pregunta o problema, no dudes en abrir un issue o contactarme.
