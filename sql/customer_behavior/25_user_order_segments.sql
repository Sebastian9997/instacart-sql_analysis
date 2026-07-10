WITH orders_by_user AS (
    SELECT 
    user_id,
    COUNT(order_id) as order_count
    FROM orders
    GROUP BY user_id
),
segmented_users AS (
    SELECT
    CASE
        WHEN order_count BETWEEN 1 AND 5 THEN '1-5 orders'
        WHEN order_count BETWEEN 6 AND 10 THEN '6-10 orders'
        WHEN order_count BETWEEN 11 AND 20 THEN '11-20 orders'
        ELSE 'More than 20 orders'
    END AS order_segment,
    COUNT(user_id) as users_count,
    CASE
        WHEN order_count BETWEEN 1 AND 5 THEN 1
        WHEN order_count BETWEEN 6 AND 10 THEN 2
        WHEN order_count BETWEEN 11 AND 20 THEN 3
        ELSE 4
    END AS segments_order
    FROM orders_by_user
    GROUP BY order_segment, segments_order
)
SELECT order_segment, users_count
FROM segmented_users
ORDER BY segments_order;