WITH ranked_products AS (
    SELECT
    d.department as department,
    p.product_name as product_name,
    COUNT(o.product_id) as product_count,
    RANK() OVER (
        PARTITION BY d.department
        ORDER BY product_count DESC
    ) AS product_rank
    FROM order_products o 
    LEFT JOIN products p ON o.product_id = p.product_id
    LEFT JOIN departments d ON p.department_id = d.department_id
    GROUP BY d.department, o.product_id, p.product_name
)
SELECT department, product_name, product_count, product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY department, product_rank ASC;