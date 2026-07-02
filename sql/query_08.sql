WITH baskets AS (
    SELECT COUNT(product_id) as basket_size
    FROM order_products
    GROUP BY order_id
    )
SELECT basket_size, COUNT(*) as distribution
FROM baskets
GROUP BY basket_size
ORDER BY basket_size ASC;