WITH raw_product_category AS (
  SELECT * FROM OLIST.RAW.raw_product_category
)

SELECT
  product_category_name,
  product_category_name_english

FROM raw_product_category