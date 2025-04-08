from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from datetime import datetime

def notify():
    print("Pipeline exécuté avec succès 🚀")

with DAG(
    dag_id='bookshop_etl',
    start_date=datetime(2025, 4, 7),
    schedule_interval='@daily',
    catchup=False,
    tags=["bookshop"],
) as dag:

    nifi_trigger = BashOperator(
        task_id='trigger_nifi_flow',
        bash_command='echo "NiFi pipeline déclenchée"',
    )

    dbt_run = BashOperator(
        task_id='dbt_run_models',
        bash_command='cd /usr/app && dbt run',
    )

    done = PythonOperator(
        task_id='done',
        python_callable=notify,
    )

    nifi_trigger >> dbt_run >> done
