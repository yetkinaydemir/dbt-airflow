{% set my_string = 'fact_order_header_'+var("date")%}
{{ config(
  materialized='table',
  alias='fact_order_header__'+var("date")
 
) }}
with fact_order_header_{{ var("date") }} as (
        SELECT
            *
        FROM `hb-dataanalytics-prod`.`komtas_model_poc`.`fact_order_header`
        WHERE date(orderDateTime) = PARSE_DATE('%Y%m%d', CAST({{var("date")}} AS STRING))
)


select * from fact_order_header_{{ var("date") }}

