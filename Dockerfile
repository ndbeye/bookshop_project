FROM python:3.11-slim

# Les dépendances système
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copie des requirements et installation des dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Installation de Cosmos, dbt et Snowflake
RUN pip install --no-cache-dir \
    astronomer-cosmos \
    dbt-core \
    dbt-postgres \
    dbt-snowflake \
    apache-airflow==2.8.1 \
    pandas \
    snowflake-connector-python \
    psycopg2-binary

# Mettre ici nos fichiers de projets dbt et dags et autres à copier
COPY ./dbt_bookshop /app/dbt
COPY ./dags /app/dags

# Le répertoire de travail à définir ici
WORKDIR /app

# Commande par défaut
CMD ["bash"]
