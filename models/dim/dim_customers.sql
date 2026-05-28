WITH src_customers AS (
  SELECT * FROM {{ref('src_customers')}}
)

SELECT 
  customer_unique_id,
  any_value(customer_city) as customer_city,
  any_value(customer_state) as customer_state
FROM src_customers
GROUP BY customer_unique_id