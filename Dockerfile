# Usa la imagen oficial de PostgreSQL
FROM postgres:15.6

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv postgresql-plpython3-15

# Crea un entorno virtual para Python
RUN python3 -m venv /opt/venv

# Crea el directorio para las credenciales de Google Cloud
RUN mkdir -p /etc/gcloud

# Copia los archivos de script y las credenciales al contenedor
COPY credentials.json /etc/gcloud/credentials.json
COPY requirements.txt /usr/local/bin/requirements.txt

# Activa el entorno virtual y instala las bibliotecas de Python necesarias
RUN /opt/venv/bin/pip install -r /usr/local/bin/requirements.txt

# Establece la variable de entorno para las credenciales de Google Cloud
ENV GOOGLE_APPLICATION_CREDENTIALS=/etc/gcloud/credentials.json

# Establece la variable de entorno para el entorno virtual
ENV PATH="/opt/venv/bin:$PATH"

# Establece la contraseña del superusuario de PostgreSQL
ENV POSTGRES_PASSWORD=mysecretpassword

# Habilita la extensión plpython3u y configura la base de datos
COPY init.sql /docker-entrypoint-initdb.d/init.sql

# Comando por defecto para iniciar PostgreSQL
CMD ["postgres"]
