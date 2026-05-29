--  Revenue Trend
SELECT
    DATE(order_purchase_ts) AS order_date,
    COUNT(order_id) AS total_orders,
    SUM(total_payment_value) AS total_revenue
FROM {{ ref('fact_orders') }}
GROUP BY 1
ORDER BY 1,

-- Delivery Performance
SELECT
    order_status,
    AVG(delivery_delay_days) AS avg_delay
FROM {{ ref('fact_orders') }}
GROUP BY 1,

-- Top Customers
SELECT
    customer_unique_id,
    COUNT(order_id) AS total_orders,
    SUM(total_payment_value) AS total_spent
FROM {{ ref('fact_orders') }}
GROUP BY 1
ORDER BY total_spent DESC
LIMIT 10,

-- Order value distribution
SELECT
    CASE 
        WHEN total_payment_value < 50 THEN 'Low'
        WHEN total_payment_value < 150 THEN 'Medium'
        ELSE 'High'
    END AS order_bucket,
    COUNT(*) AS num_orders
FROM {{ ref('fact_orders') }}
GROUP BY 1