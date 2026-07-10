WITH frequent_triples AS (
    SELECT
        t1.product_id AS product_1_id,
        t2.product_id AS product_2_id,
        t3.product_id AS product_3_id,
        COUNT(*) AS triple_count
    FROM order_products t1
    JOIN order_products t2 ON t1.order_id = t2.order_id
    JOIN order_products t3 ON t1.order_id = t3.order_id
    WHERE t1.order_id < 10000
      AND t1.product_id < t2.product_id
      AND t2.product_id < t3.product_id
    GROUP BY t1.product_id, t2.product_id, t3.product_id
    ORDER BY triple_count DESC, product_1_id, product_2_id, product_3_id
    LIMIT 10
)
SELECT
    ft.product_1_id,
    p1.product_name AS product_1_name,
    ft.product_2_id,
    p2.product_name AS product_2_name,
    ft.product_3_id,
    p3.product_name AS product_3_name,
    ft.triple_count
FROM frequent_triples ft
JOIN products p1 ON ft.product_1_id = p1.product_id
JOIN products p2 ON ft.product_2_id = p2.product_id
JOIN products p3 ON ft.product_3_id = p3.product_id
ORDER BY ft.triple_count DESC, ft.product_1_id, ft.product_2_id, ft.product_3_id;
