SELECT p.department_id, d.department, COUNT(p.product_id) AS purchase_count
FROM order_products o
LEFT JOIN products p ON o.product_id = p.product_id
LEFT JOIN departments d ON p.department_id = d.department_id
GROUP BY p.department_id, d.department
ORDER BY purchase_count DESC
LIMIT 5;
