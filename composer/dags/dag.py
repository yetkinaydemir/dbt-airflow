from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow_dbt.operators.dbt_operator import DbtSnapshotOperator
from airflow.utils.dates import days_ago 

default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
}

with DAG(
    'dbt-deneme',
    default_args=default_args,
    schedule_interval='@once'
) as dag:

    #task_1 = BashOperator(
    #    task_id = 'dbt_directory',
    #    bash_command='dbt snapshot --select dim_billing_address --project-dir=gs://europe-west1-dbt-build-4eb5c497-bucket/dags/dbt',
    #    dag=dag
    #)

    task_2 = DbtSnapshotOperator(
        task_id = 'dim_billing_address_snapshot',
        select = 'dim_billing_address',
        project_dir="gs://europe-west1-dbt-build-4eb5c497-bucket/dags/dbt/",
        dag=dag
    )

    task_2