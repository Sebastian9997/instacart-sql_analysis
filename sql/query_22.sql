SELECT user_id,
order_id,
ROW_NUMBER() OVER (
    PARTITION BY user_id
    ORDER BY order_number ASC
) as generated_order_number
FROM orders