FROM python:3.13-alpine

# Variables de entorno para no generar archivos .pyc
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Crear directorio de trabajo
WORKDIR /app

# Instalar dependencias de sistema necesarias para algunos paquetes
RUN apk add --no-cache gcc musl-dev libffi-dev

# Copiar requirements y instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir gunicorn

# Copiar el resto del código
COPY . .

# Exponer el puerto que usará Coolify
EXPOSE 5000
