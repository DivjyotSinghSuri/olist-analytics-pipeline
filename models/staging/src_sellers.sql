WITH raw_sellers AS (
  SELECT * FROM OLIST.RAW.raw_sellers
)

SELECT
  seller_id,
  seller_city,
  seller_state

FROM raw_sellers