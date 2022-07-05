from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow_dbt_python.operators.dbt import DbtSnapshotOperator, DbtTestOperator
from airflow.utils.dates import days_ago 

default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
}

with DAG(
    'dbt-snapshot',
    default_args=default_args,
    schedule_interval='@once'
) as dag:

    task_1 = DbtSnapshotOperator(
        task_id = 'dim_billing_address_snapshot',
        select = ['dim_billing_address'],
        project_dir = '/home/airflow/gcs/dags/dbt/',
        profiles_dir = '/home/airflow/gcs/data/profiles/',
        dag=dag
    )

    task_1

