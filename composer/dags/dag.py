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

    task_1 = BashOperator(
        task_id = 'dbt_directory',
        bash_command='cd /home/airflow/gcs/dags/dbt',
        dag=dag
    )

    task_2 = DbtSnapshotOperator(
        task_id = 'dim_billing_address_snapshot',
        select = 'dim_billing_address',
        dag=dag
    )

    task_1 >> task_2