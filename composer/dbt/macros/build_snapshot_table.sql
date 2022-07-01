{% macro build_snapshot_table(strategy, sql) %}

    select *,
        {{ strategy.scd_id }} as dbt_scd_id,
        {{ dbt_utils.date_trunc('second', strategy.updated_at) }} as dbt_updated_at,
        nullif(timestamp('1900-01-01 00:00:00'),{{ dbt_utils.date_trunc('second', strategy.updated_at) }}) as dbt_valid_from,
        nullif({{ dbt_utils.date_trunc('second', strategy.updated_at) }},timestamp('9999-12-31 00:00:00')) as dbt_valid_to
    from (
        {{ sql }}
    ) sbq

    
{% endmacro %}

