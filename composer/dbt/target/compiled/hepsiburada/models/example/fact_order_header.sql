

WITH skey_shipping_address AS(
        SELECT *
        FROM `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_shipping_address`
),

skey_billing_address AS(
        SELECT *
        FROM `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_billing_address`
),
skey_member AS(
        SELECT *
        FROM `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_member`
),

source_data AS (
        SELECT
            orderDateTime,
            id,
            updatedDate,
            ordernumber,
            m.member_id as member_sk,
            user_email,
            user_firstName,
            user_lastName,
            user_createdDate,
            s.dbt_scd_id as billingAddress_sk,
            b.dbt_scd_id as shippingAddress_sk,
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
            
    current_timestamp
 as dbt_created_at


        FROM `hb-dataanalytics-prod`.`komtas_model_poc`.`stg_order_header` o
        join `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_shipping_address` s on o.shippingAddress_addressRefId=s.shippingAddress_addressRefId
        and o.orderDateTime>=s.dbt_valid_from and o.orderDateTime<s.dbt_valid_to
        join `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_billing_address` b on o.billingAddress_addressRefId=b.billingAddress_addressRefId
        and o.orderDateTime>=b.dbt_valid_from and o.orderDateTime<b.dbt_valid_to
        join `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_member` m on o.user_refid=m.member_id
        and o.orderDateTime>=m.dbt_valid_from and o.orderDateTime<m.dbt_valid_to

    )

SELECT *
FROM source_data