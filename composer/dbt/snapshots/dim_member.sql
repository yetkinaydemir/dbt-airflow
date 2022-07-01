{% snapshot dim_member %}
    {{ config(
        target_schema = 'komtas_model_poc',
        strategy = 'check',
        unique_key = 'member_id',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}

    SELECT
        *
    FROM
        {{ source(
            'komtas-workshop',
            'stg_member'
        ) }}
{% endsnapshot %}
