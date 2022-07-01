{% snapshot dim_buying_category %}
    {{ config(
        target_schema = 'komtas_model_poc',
        strategy = 'check',
        unique_key = 'buyingcategoryid',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}

    SELECT
        *
    FROM
        {{ source(
            'komtas-workshop',
            'stg_buyingcategory'
        ) }}
{% endsnapshot %}
