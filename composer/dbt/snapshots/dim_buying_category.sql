{% snapshot dim_buying_category %}
    {{ config(
        target_schema = 'hepsiburada',
        strategy = 'check',
        unique_key = 'buyingcategoryid',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}

    SELECT
        {{ dbt_utils.surrogate_key(['buyingcategoryid'])}} as dim_buyingcategory_sk,
        *
    FROM
        {{ source(
            'komtas-workshop',
            'stg_buyingcategory'
        ) }}
{% endsnapshot %}
