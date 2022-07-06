{% snapshot dim_member %}
    {{ config(
        target_schema = 'hepsiburada',
        strategy = 'check',
        unique_key = 'member_id',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}

    SELECT
        {{ dbt_utils.surrogate_key(['member_id'])}} as dim_member_sk ,
        *
    FROM
        {{ source(
            'komtas-workshop',
            'stg_member'
        ) }}
{% endsnapshot %}
