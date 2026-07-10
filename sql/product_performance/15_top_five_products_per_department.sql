WITH ranked_products AS (
    SELECT
    d.department as department,
    op.product_id as product_id,
    p.product_name as product_name,
    COUNT(op.product_id) as sales_in_dept,
    DENSE_RANK() OVER(PARTITION BY d.department ORDER BY sales_in_dept DESC) as ranking
    FROM order_products op
    JOIN products p ON op.product_id = p.product_id
    JOIN departments d ON p.department_id = d.department_id
    GROUP BY d.department, op.product_id, p.product_name
    ORDER BY d.department
)
SELECT department, product_id, product_name, sales_in_dept, ranking
FROM ranked_products
WHERE ranking <= 5
ORDER BY department, ranking
