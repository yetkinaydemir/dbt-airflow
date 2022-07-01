

with fact_order_header_20220427 as (
        SELECT
            *
        FROM `hb-dataanalytics-prod`.`komtas_model_poc`.`fact_order_header`
        WHERE date(orderDateTime) = PARSE_DATE('%Y%m%d', CAST(20220427 AS STRING))
)


select * from fact_order_header_20220427