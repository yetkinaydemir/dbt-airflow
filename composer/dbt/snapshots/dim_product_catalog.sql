{% snapshot dim_product_catalog %}
    {{ config(
        target_schema = 'komtas_model_poc',
        strategy = 'check',
        unique_key = 'sku',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}


    SELECT 
       productid,
       sku,
       createddate,
       productname,
       url,
       warranty,
       brand,
       s.dbt_scd_id as buyingcategory_sk,
       store_code,
       product_type,
       product_type_desc,
       h1,
       h1_desc,
       h2,
       h2_desc,
       h3,
       h3_desc,
       h4,
       h4_desc,
       h5,
       h5_desc,
       h6,
       h6_desc
    
    FROM {{ source('komtas-workshop', 'stg_productcatalog')}} p
    LEFT JOIN `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_buying_category` s
    ON p.buyingcategoryid = s.buyingcategoryid
    AND p.createddate>= s.dbt_valid_from and p.createddate<s.dbt_valid_to

    
{% endsnapshot %}
