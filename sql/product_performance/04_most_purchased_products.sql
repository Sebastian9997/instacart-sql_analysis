SELECT p.product_id, p.product_name as name, count(*) as purchase_count
FROM order_products o
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY purchase_count DESC
LIMIT 10;