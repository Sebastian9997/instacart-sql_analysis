WITH frequent_pairs AS (
    SELECT
        t1.product_id AS product_1_id,
        t2.product_id AS product_2_id,
        COUNT(*) AS pair_count
    FROM order_products t1
    JOIN order_products t2 ON t1.order_id = t2.order_id
    WHERE t1.order_id < 1000000
      AND t1.product_id < t2.product_id
    GROUP BY t1.product_id, t2.product_id
    ORDER BY pair_count DESC, product_1_id, product_2_id
    LIMIT 10
)
SELECT
    fp.product_1_id,
    p1.product_name AS product_1_name,
    fp.product_2_id,
    p2.product_name AS product_2_name,
    fp.pair_count
FROM frequent_pairs fp
JOIN products p1 ON fp.product_1_id = p1.product_id
JOIN products p2 ON fp.product_2_id = p2.product_id
ORDER BY fp.pair_count DESC, fp.product_1_id, fp.product_2_id;
