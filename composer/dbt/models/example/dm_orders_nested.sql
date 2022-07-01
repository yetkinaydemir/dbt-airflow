{{config(materialized='table')}}

with source_data as(
    select * 
    from `hb-dataanalytics-prod`.`komtas_model_poc`.`dm_orders_nested_create_view`
)

select * from source_data