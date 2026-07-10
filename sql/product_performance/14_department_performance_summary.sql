WITH products_departments AS (
    SELECT
    d.department_id as department_id,
    d.department as department,
    COUNT(p.product_id) as products_per_department
    FROM products p
    JOIN departments d ON p.department_id = d.department_id
    GROUP BY d.department_id, d.department
),
sales_calculations AS (
    SELECT
    p.department_id as department_id,
    COUNT(op.product_id) as sales_per_department,
    AVG(op.reordered) as reorder_rate,
    SUM(sales_per_department) OVER() as total_sales,
    sales_per_department/total_sales as part_in_sales
    FROM order_products op
    JOIN products p ON op.product_id = p.product_id
    GROUP BY p.department_id
)
SELECT
pd.department as department,
pd.products_per_department as products_num,
sc.sales_per_department as sales,
sc.reorder_rate as reorder_rate,
sc.part_in_sales as sales_prcnt
FROM sales_calculations sc
JOIN products_departments pd ON sc.department_id = pd.department_id
ORDER BY sales_prcnt DESC