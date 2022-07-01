

  create or replace table `hb-dataanalytics-prod`.`komtas_model_poc`.`dm_orders_nested`
  
  
  OPTIONS()
  as (
    

with source_data as(
    select * 
    from `hb-dataanalytics-prod`.`komtas_model_poc`.`dm_orders_nested_create_view`
)

select * from source_data
  );
  