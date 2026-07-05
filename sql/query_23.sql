SELECT r.user_id as user_id,
o.order_id as order_id,
r.order_number as order_number,
COUNT(*) as basket_size,
basket_size - LAG(basket_size, 1, 0) OVER (PARTITION BY user_id ORDER BY order_number) AS basket_size_change
FROM order_products o
JOIN orders r ON o.order_id = r.order_id
GROUP BY r.user_id, o.order_id, r.order_number
ORDER BY user_id ASC, order_number ASC