SELECT o.product_id, p.product_name, COUNT(*) as product_count
FROM order_products o
LEFT JOIN products p on o.product_id = p.product_id
WHERE o.add_to_cart_order = 1
GROUP BY o.product_id, p.product_name
ORDER BY product_count DESC
LIMIT 3;