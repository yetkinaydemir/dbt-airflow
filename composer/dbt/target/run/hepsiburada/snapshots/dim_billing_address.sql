
      merge into `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_billing_address` as DBT_INTERNAL_DEST
    using `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_billing_address__dbt_tmp` as DBT_INTERNAL_SOURCE
    on DBT_INTERNAL_SOURCE.dbt_scd_id = DBT_INTERNAL_DEST.dbt_scd_id

    when matched
     and DBT_INTERNAL_DEST.dbt_valid_to = timestamp('9999-12-31 00:00:00')
     and DBT_INTERNAL_SOURCE.dbt_change_type in ('update', 'delete')
        then update
        set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to

    when not matched
     and DBT_INTERNAL_SOURCE.dbt_change_type = 'insert'
        then insert (`billingAddress_addressRefId`, `billingAddress_addressDetail`, `billingAddress_countryCode`, `billingAddress_country`, `billingAddress_city`, `billingAddress_district`, `billingAddress_userName`, `billingAddress_cityCode`, `billingAddress_townCode`, `billingAddress_districtCode`, `dbt_updated_at`, `dbt_valid_from`, `dbt_valid_to`, `dbt_scd_id`)
        values (`billingAddress_addressRefId`, `billingAddress_addressDetail`, `billingAddress_countryCode`, `billingAddress_country`, `billingAddress_city`, `billingAddress_district`, `billingAddress_userName`, `billingAddress_cityCode`, `billingAddress_townCode`, `billingAddress_districtCode`, `dbt_updated_at`, `dbt_valid_from`, `dbt_valid_to`, `dbt_scd_id`)
    
    


  