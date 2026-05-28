WITH src_sellers AS (
  SELECT * FROM {{ref('src_sellers')}}
)

select
    seller_id,
    seller_city,
    seller_state
from src_sellers