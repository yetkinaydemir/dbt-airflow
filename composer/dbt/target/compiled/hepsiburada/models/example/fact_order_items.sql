



WITH source_data AS (
        SELECT
            orderDateTime,
            id,
            ordernumber,
            updatedDate,
            tenant,
            line_item_index,
            i.sku,
            p.dbt_scd_id as sku_sk,
            name,
            unitPrice_value,
            quantity,
            tax_value,
            price_value,
            definitionName,
            i.brand,
            initialDelivery_optionName,
            initialDelivery_shippingMethodId,
            initialDelivery_isJetDelivery,
            m.dbt_scd_id as merchant_sk,
            estimatedShippingDate,
            estimatedArrivalDate,
            isFastShipping,
            shipmentPriceFinal_value,
            status,
            deliveryCode,
            cancel_reasonCode,
            cancel_requestDate,
            cancel_cancelledBy,
            extension_shippingMethodName,
            extension_buyingCategoryName,
            publishDateTime,
            
    current_timestamp
 as dbt_created_at

        FROM `hb-dataanalytics-prod`.`komtas_model_poc`.`stg_order_items` i
        left join `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_merchant` m 
        on i.merchant_id = m.merchant_id and i.orderDateTime>=m.dbt_valid_from and i.orderDateTime<m.dbt_valid_to
        left join `hb-dataanalytics-prod`.`komtas_model_poc`.`dim_product_catalog` p 
        on i.sku=p.sku and i.orderDateTime>=p.dbt_valid_from and i.orderDateTime<p.dbt_valid_to

    )

SELECT *
FROM source_data