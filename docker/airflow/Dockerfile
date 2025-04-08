FROM apache/airflow:2.8.0

USER root
RUN pip install dbt-core dbt-snowflake

COPY ./dags /opt/airflow/dags
