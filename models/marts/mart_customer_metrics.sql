SELECT
    customer_unique_id,
    COUNT(order_id) AS total_orders,
    SUM(total_payment_value) AS lifetime_value,
    {{ safe_divide('SUM(total_payment_value)', 'COUNT(order_id)') }} AS avg_order_value
FROM {{ ref('fact_orders') }}
GROUP BY 1