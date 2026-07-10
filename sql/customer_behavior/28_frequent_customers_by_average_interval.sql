SELECT user_id,
AVG(days_since_prior_order) AS avg_days_between_orders,
COUNT(order_id) as orders_count
FROM orders
GROUP BY user_id
HAVING orders_count > 3 AND avg_days_between_orders < 7
ORDER BY avg_days_between_orders, user_id;
