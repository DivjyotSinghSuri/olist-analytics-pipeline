WITH src_product AS (
  SELECT * FROM {{ ref('src_products') }} p
left join {{ ref('src_product_category') }} t
  on p.product_category_name = t.product_category_name
)

select
    product_id,
    product_category_name_english as category,
    product_weight_g
from src_product