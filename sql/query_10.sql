SELECT 
a.aisle as aisle_name,
COUNT(o.product_id) as sales_volume
FROM order_products o
LEFT JOIN products p on o.product_id = p.product_id
LEFT JOIN aisles a on p.aisle_id = a.aisle_id
GROUP BY a.aisle
ORDER BY sales_volume DESC
LIMIT 5;