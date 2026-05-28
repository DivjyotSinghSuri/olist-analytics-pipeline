WITH src_dates AS (
  SELECT * FROM {{ref('src_orders')}}
)

select DISTINCT
    date(order_purchase_ts) as order_date,
    extract(year from order_purchase_ts) as year,
    extract(month from order_purchase_ts) as month
from src_dates