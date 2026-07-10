SELECT user_id, MAX(order_number) as number_of_orders
FROM orders
GROUP BY user_id
ORDER BY number_of_orders DESC
LIMIT 20;