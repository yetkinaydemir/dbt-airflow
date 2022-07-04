from airflow import DAG
from airflow.operators.bash import BashOperator
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
        task_id = 'dim_billing_address_snapshot',
        bash_command = 'dbt snapshot --select dim_billing_address',
        dag=dag
    )

    task_1