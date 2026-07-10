
WITH last_item_in_order AS (
    SELECT 
    order_id, 
    MAX(add_to_cart_order) as last_item_added
    FROM order_products
    GROUP BY order_id
)
SELECT o.product_id as ID, p.product_name as product_name, COUNT(*) as product_count
FROM order_products o
JOIN last_item_in_order l ON o.order_id = l.order_id AND o.add_to_cart_order = l.last_item_added
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY o.product_id, p.product_name
ORDER BY product_count DESC
LIMIT 3;

