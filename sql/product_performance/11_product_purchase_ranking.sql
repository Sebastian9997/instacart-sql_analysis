SELECT p.product_name,
COUNT(o.product_id) AS product_count,
RANK() OVER (ORDER BY product_count DESC) as ranking
FROM order_products o
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY o.product_id, p.product_name
ORDER BY ranking, o.product_id
LIMIT 10;
