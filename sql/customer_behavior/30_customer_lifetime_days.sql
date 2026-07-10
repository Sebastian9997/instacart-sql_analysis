SELECT
user_id,
COUNT(order_id) as orders_count,
SUM(days_since_prior_order) as days_between_first_and_last_order
FROM orders
GROUP BY user_id
ORDER BY days_between_first_and_last_order DESC
