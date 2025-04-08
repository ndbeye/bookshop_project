FROM python:3.9-slim

WORKDIR /usr/app

RUN pip install --upgrade pip && \
    pip install dbt-core dbt-snowflake

COPY . .

ENTRYPOINT ["dbt"]