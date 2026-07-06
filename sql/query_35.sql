SELECT
op.product_id,
p.product_name,
COUNT(op.product_id) as product_count,
AVG(op.reordered) as reorder_rate
FROM order_products op
JOIN products p ON op.product_id = p.product_id
GROUP BY op.product_id, p.product_name
HAVING COUNT(op.product_id) >= 1000
ORDER BY reorder_rate DESC
LIMIT 1;