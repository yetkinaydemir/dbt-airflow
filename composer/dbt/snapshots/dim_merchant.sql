{% snapshot dim_merchant %}
    {{ config(
        target_schema = 'hepsiburada',
        strategy = 'check',
        unique_key = 'merchant_id',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}

    SELECT
        {{ dbt_utils.surrogate_key(['merchant_id'])}} as dim_merchant_sk ,
        *
    FROM
        {{ source(
            'komtas-workshop',
            'stg_merchant'
        ) }}
{% endsnapshot %}
