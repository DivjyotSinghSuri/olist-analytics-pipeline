WITH raw_products AS (
  SELECT * FROM OLIST.RAW.raw_products
)

SELECT
  product_id,
  product_category_name,
  product_weight_g

FROM raw_products