SELECT MAX(basket_size) as max_basket_size
FROM(
    SELECT COUNT(product_id) as basket_size
    FROM order_products
    GROUP BY order_id
);