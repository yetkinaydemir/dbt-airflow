{{ config(
    materialized='table',
    partition_by={
      "field": "orderDateTime",
      "data_type": "timestamp",
      "granularity": "day"
    },
   

    )}}

WITH skey_shipping_address AS(
        SELECT *
        FROM `komtas-workshop`.`hepsiburada`.`dim_shipping_address`
),

skey_billing_address AS(
        SELECT *
        FROM `komtas-workshop`.`hepsiburada`.`dim_billing_address`
),
skey_member AS(
        SELECT *
        FROM `komtas-workshop`.`hepsiburada`.`dim_member`
),

source_data AS (
        SELECT
            orderDateTime,
            id,
            updatedDate,
            ordernumber,
            m.dim_member_sk,
            user_email,
            user_firstName,
            user_lastName,
            user_createdDate,
            b.dim_billing_address_sk,
            s.dim_shipping_address_sk,
            totalAmount_value,
            totalSellingPrice_value,
            totalSellingPrice_currencyCode,
            fraudState,
            confirmation_status,
            confirmation_date,
            tenant,
            completion_status,
            completion_reason,
            extension_orderOrigin,
            publishDateTime,
            {{dbt_utils.current_timestamp()}} as dbt_created_at


        FROM `komtas-workshop`.`hepsiburada`.`stg_order_header` o
        join `komtas-workshop`.`hepsiburada`.`dim_shipping_address` s on o.shippingAddress_addressRefId=s.shippingAddress_addressRefId
        and o.orderDateTime>=s.dbt_valid_from and o.orderDateTime<s.dbt_valid_to
        join `komtas-workshop`.`hepsiburada`.`dim_billing_address` b on o.billingAddress_addressRefId=b.billingAddress_addressRefId
        and o.orderDateTime>=b.dbt_valid_from and o.orderDateTime<b.dbt_valid_to
        join `komtas-workshop`.`hepsiburada`.`dim_member` m on o.user_refid=m.member_id
        and o.orderDateTime>=m.dbt_valid_from and o.orderDateTime<m.dbt_valid_to

    )

SELECT *
FROM source_data

