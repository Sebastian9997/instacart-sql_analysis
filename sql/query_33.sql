WITH table1 AS (
    SELECT
    o.user_id as user_id,
    p.department_id as department_id,
    COUNT(*) as purchases_in_dept,
    SUM(purchases_in_dept) OVER (PARTITION BY o.user_id) as total_purchases,
    purchases_in_dept/total_purchases as loyalty_rate
    FROM order_products op
    JOIN orders o ON op.order_id = o.order_id
    JOIN products p ON op.product_id = p.product_id
    GROUP BY o.user_id, p.department_id
)
SELECT 
user_id, 
department_id,
total_purchases,
loyalty_rate
FROM table1
WHERE total_purchases >= 50
ORDER BY loyalty_rate DESC, total_purchases DESC
LIMIT 1;