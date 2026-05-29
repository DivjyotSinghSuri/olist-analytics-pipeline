SELECT
    DATE(order_purchase_ts) AS order_date,
    COUNT(order_id) AS total_orders,
    SUM(total_payment_value) AS total_revenue,
    AVG(total_payment_value) AS avg_order_value,
    AVG(delivery_delay_days) AS avg_delay
FROM {{ ref('fact_orders') }}
GROUP BY 1