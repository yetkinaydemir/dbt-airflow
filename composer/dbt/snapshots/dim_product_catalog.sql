{% snapshot dim_product_catalog %}
    {{ config(
        target_schema = 'hepsiburada',
        strategy = 'check',
        unique_key = 'sku',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}


    SELECT 
       {{ dbt_utils.surrogate_key(['sku'])}} as dim_productcatalog_sk ,
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
    LEFT JOIN `komtas-workshop`.`hepsiburada`.`dim_buying_category` s
    ON p.buyingcategoryid = s.buyingcategoryid
    AND p.createddate>= s.dbt_valid_from and p.createddate<s.dbt_valid_to

    
{% endsnapshot %}
