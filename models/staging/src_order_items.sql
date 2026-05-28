WITH raw_order_items AS (
  SELECT * FROM OLIST.RAW.raw_order_items
)

SELECT
  order_id,
  order_item_id,
  product_id,
  seller_id,
  price,
  freight_value

FROM raw_order_items