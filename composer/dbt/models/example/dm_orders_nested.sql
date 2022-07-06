{{config(materialized='table')}}

with source_data as(
    select * 
    from `komtas-workshop`.`hepsiburada`.`dm_orders_nested_create_view`
)

select * from source_data