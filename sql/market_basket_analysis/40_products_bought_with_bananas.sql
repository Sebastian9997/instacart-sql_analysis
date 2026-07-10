WITH bananas_id AS (
    SELECT product_id
    FROM products
    WHERE product_name LIKE '%Banana%'
),
orders_with_bananas AS (
    SELECT DISTINCT o.order_id
    FROM order_products o
    WHERE o.product_id IN (SELECT product_id FROM bananas_id)
),
top_products AS (
    SELECT
    o.product_id,
    COUNT(o.product_id) as product_count
    FROM order_products o
    WHERE o.order_id IN (SELECT order_id FROM orders_with_bananas)
    AND o.product_id NOT IN (SELECT product_id FROM bananas_id)
    GROUP BY o.product_id
    ORDER BY product_count DESC
    LIMIT 5
)
SELECT
t.product_id,
p.product_name,
t.product_count
FROM top_products t
LEFT JOIN products p ON t.product_id = p.product_id
ORDER BY product_count DESC
