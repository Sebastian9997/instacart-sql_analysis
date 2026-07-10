WITH users_ranked AS (
    SELECT user_id,
    COUNT(order_id) as order_count,
    PERCENT_RANK() OVER(ORDER BY order_count DESC) as percent_rank
    FROM orders
    GROUP BY user_id
)
SELECT *
FROM users_ranked
WHERE percent_rank <= 0.10