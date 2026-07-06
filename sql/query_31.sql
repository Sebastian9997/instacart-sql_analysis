WITH products_sequence AS (
    SELECT
    order_id,
    product_id,
    LEAD(product_id, 1) OVER(
        PARTITION BY order_id
        ORDER BY add_to_cart_order
    ) as next_product
    FROM order_products
),
frequent_pairs AS (
    SELECT
    product_id,
    next_product,
    COUNT(*) as pair_count
    FROM products_sequence
    WHERE next_product IS NOT NULL
    GROUP BY product_id, next_product
    ORDER BY pair_count DESC
    LIMIT 10
)
SELECT
f.product_id as before_product_id,
p_before.product_name as before_product_name,
f.next_product as next_product_id,
p_next.product_name as next_product_name,
f.pair_count
FROM frequent_pairs f
LEFT JOIN products p_before
ON f.product_id = p_before.product_id
LEFT JOIN products p_next
ON f.next_product = p_next.product_id
ORDER BY f.pair_count DESC;
