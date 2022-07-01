{% snapshot dim_merchant %}
    {{ config(
        target_schema = 'komtas_model_poc',
        strategy = 'check',
        unique_key = 'merchant_id',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}

    SELECT
        *
    FROM
        {{ source(
            'komtas-workshop',
            'stg_merchant'
        ) }}
{% endsnapshot %}
