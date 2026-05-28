WITH raw_orders AS (
  SELECT * FROM OLIST.RAW.raw_orders
)

SELECT
  order_id,
  customer_id,
  order_status,

  order_purchase_timestamp AS order_purchase_ts,
  order_approved_at AS order_approved_ts,
  order_delivered_customer_date AS delivered_ts,
  order_estimated_delivery_date AS estimated_delivery_ts

FROM raw_orders