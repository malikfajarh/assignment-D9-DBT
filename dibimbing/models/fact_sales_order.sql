-- fact_sales_order
{{
  config(
    materialized='table'
  )
}}

SELECT 
  `Order ID` AS order_id, 
  Date AS date,
  Status AS status,
  {{ dbt_utils.generate_surrogate_key([
				'SKU'
			]) }} as product_id,
  {{ dbt_utils.generate_surrogate_key([
				'Fulfilment', 
				'`fulfilled-by`'
			])}} AS fulfillment_id,
  {{ dbt_utils.generate_surrogate_key([
				'`promotion-ids`'
			]) }} as promotion_id,
  {{ dbt_utils.generate_surrogate_key([
				'`Sales Channel `',
        'B2B'
			]) }} as sales_channel_id,
  {{ dbt_utils.generate_surrogate_key([
				'`ship-city`',
        '`ship-postal-code`'
			]) }} as sales_shipment_id,
  SUM(qty) AS qty,
  COALESCE(SUM(amount),0) AS amount,
FROM
    {{ source('bronze', 'amazon_sale_report') }}
GROUP BY ALL