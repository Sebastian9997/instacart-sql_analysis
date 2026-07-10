SELECT d.department, COUNT(p.product_id) AS product_count
FROM products p
LEFT JOIN departments d ON p.department_id = d.department_id
GROUP BY d.department
ORDER BY COUNT(p.product_id) DESC;