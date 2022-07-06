{{ config(
    materialized='table',
    partition_by={
      "field": "orderDateTime",
      "data_type": "timestamp",
      "granularity": "day"
    },
   

    )}}



WITH source_data AS (
        SELECT
            orderDateTime,
            id,
            ordernumber,
            updatedDate,
            tenant,
            line_item_index,
            i.sku,
            p.dim_productcatalog_sk,
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
            m.dim_merchant_sk,
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
            {{dbt_utils.current_timestamp()}} as dbt_created_at

        FROM {{source('komtas-workshop','stg_order_items')}} i
        left join `komtas-workshop`.`hepsiburada`.`dim_merchant` m 
        on i.merchant_id = m.merchant_id and i.orderDateTime>=m.dbt_valid_from and i.orderDateTime<m.dbt_valid_to
        left join `komtas-workshop`.`hepsiburada`.`dim_product_catalog` p 
        on i.sku=p.sku and i.orderDateTime>=p.dbt_valid_from and i.orderDateTime<p.dbt_valid_to

    )

SELECT *
FROM source_data

