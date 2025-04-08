from airflow import DAG
from cosmos.providers.dbt.core.operators import DbtRunOperator
from cosmos.providers.dbt.core.operators import DbtTestOperator
from cosmos.providers.dbt.core.operators import DbtSeedOperator
from cosmos.providers.dbt.core.operators import DbtDepsOperator

from datetime import datetime

default_args = {
    "owner": "airflow",
    "start_date": datetime(2024, 1, 1),
}

with DAG(
    dag_id="cosmos_dbt_dag",
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
    tags=["dbt", "cosmos"],
) as dag:

    deps = DbtDepsOperator(
        task_id="install_dbt_packages",
        project_dir="/app/dbt"
    )

    seed = DbtSeedOperator(
        task_id="dbt_seed",
        project_dir="/app/dbt"
    )

    run = DbtRunOperator(
        task_id="dbt_run",
        project_dir="/app/dbt"
    )

    test = DbtTestOperator(
        task_id="dbt_test",
        project_dir="/app/dbt"
    )

    deps >> seed >> run >> test
