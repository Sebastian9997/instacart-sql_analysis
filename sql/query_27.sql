WITH reordered_products AS (
    SELECT product_id
    FROM order_products
    WHERE reordered = 1
)
SELECT
d.department as department,
COUNT(rp.product_id) as product_count
FROM reordered_products rp
LEFT JOIN products p ON rp.product_id = p.product_id
LEFT JOIN departments d ON p.department_id = d.department_id
GROUP BY d.department
ORDER BY product_count DESC
LIMIT 1;
