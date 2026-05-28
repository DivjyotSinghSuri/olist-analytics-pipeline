{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}
WITH orders AS (
    SELECT * FROM {{ ref('src_orders') }}

    {% if is_incremental() %}
  WHERE order_purchase_ts >= (
    SELECT MAX(order_purchase_ts)
    FROM {{ this }}
  )
{% endif %}
),

customers AS (
    SELECT * FROM {{ ref('src_customers') }}
),

payments AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_payment_value
    FROM {{ ref('src_order_payments') }}
    GROUP BY order_id
),

order_items AS (
    SELECT
        order_id,
        COUNT(*) AS total_items,
        SUM(price) AS total_price,
        SUM(freight_value) AS total_freight
    FROM {{ ref('src_order_items') }}
    GROUP BY order_id
),

reviews AS (
    SELECT
        order_id,
        MAX(review_score) AS review_score
    FROM {{ ref('src_order_reviews') }}
    GROUP BY order_id
)

SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,

    -- location
    c.customer_city,
    c.customer_state,

    -- order status & timestamps
    o.order_status,
    o.order_purchase_ts,
    o.order_approved_ts,
    o.delivered_ts,
    o.estimated_delivery_ts,

    -- revenue
    p.total_payment_value,

    -- item metrics
    oi.total_items,
    oi.total_price,
    oi.total_freight,

    -- review
    r.review_score,

    -- derived metric
    CASE 
      WHEN o.delivered_ts IS NOT NULL AND o.estimated_delivery_ts IS NOT NULL
      THEN DATEDIFF('day', o.estimated_delivery_ts, o.delivered_ts)
    END AS delivery_delay_days

FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id

LEFT JOIN payments p
    ON o.order_id = p.order_id

LEFT JOIN order_items oi
    ON o.order_id = oi.order_id

LEFT JOIN reviews r
    ON o.order_id = r.order_id


