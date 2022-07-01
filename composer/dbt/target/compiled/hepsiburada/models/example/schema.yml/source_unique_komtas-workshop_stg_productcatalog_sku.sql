
    
    

with dbt_test__target as (

  select sku as unique_field
  from `hb-dataanalytics-prod`.`komtas_model_poc`.`stg_productcatalog`
  where sku is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


