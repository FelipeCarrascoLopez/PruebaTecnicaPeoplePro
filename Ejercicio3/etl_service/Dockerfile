FROM python:3.9-slim

# Instalar las dependencias de PostgreSQL
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copia el archivo de requisitos primero para aprovechar el caché de Docker
COPY requirements.txt .

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto de tu aplicación
COPY . .

# Comando para ejecutar el script
CMD ["python", "etl_script.py"]
