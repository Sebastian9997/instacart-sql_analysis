SELECT
p.department_id,
d.department,
COUNT(DISTINCT op.product_id) as distinct_product_id
FROM order_products op
JOIN products p ON op.product_id = p.product_id
JOIN departments d ON p.department_id = d.department_id
GROUP BY p.department_id, d.department
ORDER BY distinct_product_id DESC
LIMIT 1;