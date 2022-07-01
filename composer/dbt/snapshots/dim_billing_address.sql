{% snapshot dim_billing_address %}
    {{ config(
        target_schema = 'komtas_model_poc',
        strategy = 'check',
        unique_key = 'billingAddress_addressRefId',
        check_cols = 'all',
        invalidate_hard_deletes = True
    ) }}

    SELECT 
        *       
    FROM `hb-dataanalytics-prod`.`komtas_model_poc`.`stg_billing_address`
       
{% endsnapshot %}
