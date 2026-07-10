SELECT 
p.department_id as dept_ID,
d.department as dept_name,
ROUND(AVG(o.reordered)*100,2) as reorder_rate
FROM order_products o
LEFT JOIN products p ON o.product_id = p.product_id
LEFT JOIN departments d ON p.department_id = d.department_id
GROUP BY p.department_id, d.department
ORDER BY reorder_rate DESC
LIMIT 1;