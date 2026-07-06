SELECT 
t1.product_id as product_1,
t2.product_id as product_2,
COUNT(*) as pair_count
FROM order_products t1, order_products t2
WHERE t1.order_id < 1000000 
AND t1.order_id = t2.order_id 
AND t1.product_id < t2.product_id
GROUP BY product_1, product_2
ORDER BY pair_count DESC
LIMIT 10;