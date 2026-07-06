SELECT 
t1.product_id as product_1,
t2.product_id as product_2,
t3.product_id as product_3,
COUNT(*) as tri_count
FROM order_products t1
JOIN order_products t2 ON t1.order_id = t2.order_id
JOIN order_products t3 ON t1.order_id = t3.order_id
WHERE t1.order_id < 10000 
AND t1.product_id < t2.product_id
AND t2.product_id < t3.product_id
GROUP BY product_1, product_2, product_3
ORDER BY tri_count DESC
LIMIT 10;