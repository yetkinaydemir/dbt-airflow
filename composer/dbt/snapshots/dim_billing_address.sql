{% snapshot dim_billing_address %}
    {{ config(
        target_schema = 'hepsiburada',
        strategy = 'check',
        unique_key = 'billingAddress_addressRefId',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}

    SELECT 
        {{ dbt_utils.surrogate_key(['billingAddress_addressRefId'])}} as dim_billing_address_sk,
        *       
    FROM `komtas-workshop`.`hepsiburada`.`stg_billing_address`
       
{% endsnapshot %}
