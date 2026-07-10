WITH product_reorder_rate AS (
    SELECT
    o.product_id as product_id,
    p.department_id as department_id,
    AVG(o.reordered) as reorder_rate
    FROM order_products o
    JOIN products p ON o.product_id = p.product_id
    GROUP BY o.product_id, p.department_id
),
ranked_products AS (
    SELECT
    department_id,
    product_id,
    reorder_rate,
    RANK() OVER(PARTITION BY department_id ORDER BY reorder_rate DESC) as ranked
    FROM product_reorder_rate
)
SELECT d.department, p.product_name, rp.reorder_rate
FROM ranked_products rp
JOIN departments d ON rp.department_id = d.department_id
JOIN products p ON rp.product_id = p.product_id
WHERE ranked = 1