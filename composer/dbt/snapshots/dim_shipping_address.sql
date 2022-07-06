{% snapshot dim_shipping_address %}
    {{ config(
        target_schema = 'hepsiburada',
        strategy = 'check',
        unique_key = 'shippingAddress_addressRefId',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}

    SELECT
        {{ dbt_utils.surrogate_key(['shippingAddress_addressRefId'])}} as dim_shipping_address_sk,
        *
    FROM
        {{ source(
            'komtas-workshop',
            'stg_shipping_address'
        ) }}
{% endsnapshot %}
