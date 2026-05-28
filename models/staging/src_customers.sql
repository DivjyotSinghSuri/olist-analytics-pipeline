WITH raw_customers AS (
  SELECT * FROM OLIST.RAW.raw_customers
)

SELECT customer_id,
  customer_unique_id,
  customer_city,
  customer_state
FROM raw_customers;