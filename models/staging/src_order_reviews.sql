WITH raw_reviews AS (
  SELECT * FROM OLIST.RAW.raw_order_reviews
)

SELECT
  order_id,
  review_score,
  review_creation_date AS review_creation_ts

FROM raw_reviews