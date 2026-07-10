WITH orders_by_user_with_size AS (
    SELECT
    r.user_id as user_id,
    r.order_number as order_number,
    op.order_id as order_id,
    COUNT(op.product_id) as basket_size
    FROM order_products op
    JOIN orders r ON op.order_id = r.order_id
    GROUP BY r.user_id, r.order_number, op.order_id
)
SELECT
user_id,
order_number,
order_id,
basket_size,
AVG(basket_size) OVER(
    PARTITION BY user_id
    ORDER BY order_number
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) as moving_avg_basket_size
FROM orders_by_user_with_size
ORDER BY user_id, order_number