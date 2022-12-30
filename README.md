## About the Project ##

I have run dbt snapshot from Airflow(running on Cloud Composer) by creating a DAG script and also used Cloud Build for CI/CD.

This repository is not including the whole project. It only gives you an idea on using dbt with Airflow.

## Built With ##

* dbt
* Airflow
* Cloud Composer(Google Cloud Platform)
* Cloud Build(Google Cloud Platform)
* BigQuery(Google Cloud Platform)

## Requirements ##

1. Install a code editor for building your dbt project, creating DAG script, creating yaml file for cloud build.
2. Install dbt-core and dbt-bigquery with ``pip`` using [this link](https://docs.getdbt.com/docs/get-started/pip-install).
3. Have an Airflow environment whether it is on-prem or on cloud to be able to run DAG script.
4. Google Cloud Platform(GCP) project.
