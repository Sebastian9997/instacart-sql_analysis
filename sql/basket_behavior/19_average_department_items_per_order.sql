WITH basket_by_department AS (
    SELECT
    o.order_id as orderID,
    d.department as department_name,
    COUNT(p.product_id) as product_count
    FROM order_products o
    LEFT JOIN products p ON o.product_id = p.product_id
    LEFT JOIN departments d ON p.department_id = d.department_id
    GROUP BY o.order_id, d.department
)
SELECT
department_name,
ROUND(AVG(product_count), 2) AS avg_department_items_per_order
FROM basket_by_department
GROUP BY department_name
ORDER BY avg_department_items_per_order DESC;
