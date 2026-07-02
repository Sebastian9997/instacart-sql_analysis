SELECT AVG(basket_size) as avg_basket_size
FROM(
    SELECT COUNT(product_id) as basket_size
    FROM order_products
    GROUP BY order_id
);