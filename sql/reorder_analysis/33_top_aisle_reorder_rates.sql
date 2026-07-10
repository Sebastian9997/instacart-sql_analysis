SELECT
a.aisle as aisle_name,
ROUND(AVG(o.reordered)*100,2) as reorder_rate
FROM order_products o
LEFT JOIN products p ON o.product_id = p.product_id
LEFT JOIN aisles a ON p.aisle_id = a.aisle_id
GROUP BY aisle_name
ORDER BY reorder_rate DESC
LIMIT 3;