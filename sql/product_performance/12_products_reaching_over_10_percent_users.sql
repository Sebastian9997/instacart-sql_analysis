WITH counted_total_users AS (
    SELECT 
    COUNT(DISTINCT user_id) as total_users
    FROM orders
),
product_user_pairs AS (
    SELECT
    o.product_id AS product_id,
    COUNT(DISTINCT r.user_id) AS count_product_users
    FROM order_products o
    JOIN orders r ON o.order_id = r.order_id
    GROUP BY o.product_id
)
SELECT
p.product_id,
pr.product_name,
ROUND(p.count_product_users/t.total_users, 2) as users_rate
FROM product_user_pairs p
LEFT JOIN products pr ON p.product_id = pr.product_id
CROSS JOIN counted_total_users t
WHERE p.count_product_users/t.total_users > 0.1
ORDER BY users_rate DESC;
