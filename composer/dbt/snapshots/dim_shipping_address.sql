{% snapshot dim_shipping_address %}
    {{ config(
        target_schema = 'komtas_model_poc',
        strategy = 'check',
        unique_key = 'shippingAddress_addressRefId',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}

    SELECT
        *
    FROM
        {{ source(
            'komtas-workshop',
            'stg_shipping_address'
        ) }}
{% endsnapshot %}
