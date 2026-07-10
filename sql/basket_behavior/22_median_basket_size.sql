WITH baskets AS (
    SELECT
    COUNT(product_id) as basket_size,
    ROW_NUMBER() OVER(ORDER BY basket_size) as index
    FROM order_products
    GROUP BY order_id
    ORDER BY basket_size
)
SELECT
AVG(basket_size) as median_basket_size
FROM baskets
WHERE index IN (
    (SELECT FLOOR(MAX(index + 1)/2) FROM baskets),
    (SELECT CEIL(MAX(index + 1)/2) FROM baskets)
    )
