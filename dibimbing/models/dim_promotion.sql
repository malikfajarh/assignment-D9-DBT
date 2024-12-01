-- dim_promotion
{{
  config(
    materialized='table'
  )
}}

With t_data AS (
SELECT DISTINCT 
  `promotion-ids` AS promotion
FROM
    {{ source('bronze', 'amazon_sale_report') }}
)

SELECT 
{{ dbt_utils.generate_surrogate_key([
				'promotion'
			]) }} as promotion_id, *
FROM t_data