# SQL Query Catalog

This catalog presents all 40 analyses in the project. Results were generated with
DuckDB from the Kaggle source files listed in the [project README](../README.md).
Counts described as purchases refer to order-product rows because the dataset does not
contain prices or revenue.

## Dataset overview

| ID | Business question | SQL techniques | Representative result and interpretation |
|---:|---|---|---|
| [01](../sql/dataset_overview/01_unique_users.sql)) | How many unique users are included? | `COUNT DISTINCT` | **206,209 users.** This is the customer population used in user-level analyses. |
| [02](../sql/dataset_overview/02_total_orders.sql)) | How many orders have been placed? | `COUNT DISTINCT` | **3,421,083 orders.** This includes prior, train, and test orders in the source order table. |
| [03](../sql/dataset_overview/03_products_by_department.sql)) | How many catalog products belong to each department? | `LEFT JOIN`, aggregation | **Personal care: 6,563 products**, the largest product catalog among departments. |

## Product performance

| ID | Business question | SQL techniques | Representative result and interpretation |
|---:|---|---|---|
| [04](../sql/product_performance/04_most_purchased_products.sql)) | Which products are purchased most frequently? | joins, `GROUP BY`, top-N | **Banana: 491,291 purchases**, the leading individual product. |
| [05](../sql/product_performance/05_least_purchased_products.sql)) | Which products have the fewest recorded purchases? | aggregation, `HAVING`, top-N | Multiple products appear only **once**; the query returns ten examples rather than treating tied rows as a unique bottom ten. |
| [06](../sql/product_performance/06_purchases_by_department.sql)) | Which departments account for the most purchases? | multi-table joins, aggregation | **Produce: 9,888,378 purchases**, the highest department volume. |
| [07](../sql/product_performance/07_purchases_by_aisle.sql)) | Which aisles have the highest purchase volume? | multi-table joins, top-N | **Fresh fruits: 3,792,661 purchases**, the leading aisle. |
| [08](../sql/product_performance/08_first_added_products.sql)) | Which products are most frequently added to the cart first? | conditional filtering, aggregation | **Banana: 115,521 first positions**, making it the most common cart starter. |
| [09](../sql/product_performance/09_last_added_products.sql)) | Which products are most frequently added to the cart last? | CTE, per-order maximum, compound join | **Banana: 31,140 last positions**, also the most common final addition. |
| [10](../sql/product_performance/10_top_products_per_department.sql)) | What are the top three products within every department? | CTE, `RANK`, partitioned window | Example: **Sauvignon Blanc leads alcohol with 8,541 purchases**. Ties can return more than three rows per department. |
| [11](../sql/product_performance/11_product_purchase_ranking.sql)) | What are the ten highest-ranked products by purchases? | aggregation, `RANK`, deterministic top-N | **Banana ranks first with 491,291 purchases.** The final ordering makes the limited result reproducible. |
| [12](../sql/product_performance/12_products_reaching_over_10_percent_users.sql)) | Which products were purchased by more than 10% of users? | multiple CTEs, distinct users, cross join | **Banana reached 37% of users**, the broadest customer penetration. Rates are rounded for display after filtering on the exact value. |
| [13](../sql/product_performance/13_department_product_diversity.sql)) | Which department has the widest purchased product variety? | `COUNT DISTINCT`, joins | **Personal care: 6,563 distinct products purchased.** In this dataset it matches the department's catalog breadth. |
| [14](../sql/product_performance/14_department_performance_summary.sql)) | How do departments compare on breadth, volume, reorder rate, and purchase share? | multiple CTEs, window total, ratio metrics | **Produce contributes 9,888,378 purchases and 29.24% of volume**, with a 65.05% reorder rate. |
| [15](../sql/product_performance/15_top_five_products_per_department.sql)) | What are the top five products per department, including ties? | CTE, `DENSE_RANK`, partitioned window | Example: **Sauvignon Blanc ranks first in alcohol with 8,541 purchases**. Product names are included for readable output. |

## Basket behaviour

| ID | Business question | SQL techniques | Representative result and interpretation |
|---:|---|---|---|
| [16](../sql/basket_behavior/16_average_basket_size.sql)) | What is the average basket size? | nested aggregation | **10.11 products per observed basket** on average. Only orders with product-level records are included. |
| [17](../sql/basket_behavior/17_maximum_basket_size.sql)) | What is the largest observed basket? | grouped count, `MAX` | **145 products** in the largest basket. |
| [18](../sql/basket_behavior/18_basket_size_distribution.sql)) | How are basket sizes distributed? | CTE, frequency distribution | **163,593 baskets contain one product.** The full result provides a frequency for every observed size. |
| [19](../sql/basket_behavior/19_average_department_items_per_order.sql)) | How many items from each department appear in an order containing that department? | CTE, order-department aggregation | Orders containing produce average **3.95 produce items**, the highest department-specific item count. This is not total basket size. |
| [20](../sql/basket_behavior/20_basket_size_change.sql)) | How does each basket compare with the customer's previous observed basket? | aggregation, `LAG`, partitioned sequence | Example user 1 starts with **5 items**. The first change is measured against zero; later rows compare consecutive observed baskets. |
| [21](../sql/basket_behavior/21_consistently_growing_baskets.sql)) | Which users increased basket size at every observed order? | CTE, `LAG`, grouped condition | Example user 24,315 has **3 orders and a minimum increase of 2 items**. Users need at least two observed baskets. |
| [22](../sql/basket_behavior/22_median_basket_size.sql)) | What is the median basket size? | `ROW_NUMBER`, floor/ceiling median positions | The median observed basket contains **8 products**. The calculation supports both odd and even row counts. |
| [23](../sql/basket_behavior/23_rolling_average_basket_size.sql)) | What is each user's three-order rolling average basket size? | CTE, ordered window frame | Example user 1 starts with **5 items and a rolling average of 5.0**; later rows use the current and two preceding observed orders. |

## Customer behaviour

| ID | Business question | SQL techniques | Representative result and interpretation |
|---:|---|---|---|
| [24](../sql/customer_behavior/24_most_active_users.sql)) | Which users placed the most orders? | grouped maximum, top-N | The most active users reach the dataset cap of **100 orders**; the query returns 20 examples from the tied group. |
| [25](../sql/customer_behavior/25_user_order_segments.sql)) | How are users distributed across order-frequency segments? | multiple CTEs, `CASE`, custom ordering | **43,576 users placed 1–5 orders.** The result also covers 6–10, 11–20, and more than 20 orders. |
| [26](../sql/customer_behavior/26_top_ten_percent_users.sql)) | Which users belong to the top 10% by order count? | grouped count, `PERCENT_RANK` | Users at the top have **100 orders and percent rank 0**. Boundary ties are retained by the window ranking. |
| [27](../sql/customer_behavior/27_generated_order_sequence.sql)) | Can order sequence be recreated with a window function? | `ROW_NUMBER`, partitioned ordering | Example: user 55's order 2,080,943 receives generated sequence **1**. This can be compared with the supplied `order_number`. |
| [28](../sql/customer_behavior/28_frequent_customers_by_average_interval.sql)) | Which customers average fewer than seven days between orders and have more than three orders? | aggregation, `HAVING`, deterministic ordering | Example user 14,433 has **7 orders and a 0-day average interval**. The condition applies to the average, not every individual gap. |
| [29](../sql/customer_behavior/29_strongest_department_loyalty.sql)) | Which user has the strongest concentration in one department? | grouped shares, window sum, filtering | User 201,038 made **all 530 purchases in department 4 (produce)**. At least 50 purchases are required. |
| [30](../sql/customer_behavior/30_customer_lifetime_days.sql)) | What is the estimated observed lifetime and order count per user? | aggregation, interval summation | The longest observed lifetimes reach **365 days**; example user 46,321 placed 78 orders. Summed gaps estimate time from first to last order. |

## Reorder analysis

| ID | Business question | SQL techniques | Representative result and interpretation |
|---:|---|---|---|
| [31](../sql/reorder_analysis/31_top_department_reorder_rate.sql)) | Which department has the highest reorder rate? | multi-table joins, binary average | **Dairy & eggs: 67.02%**, the highest department-level reorder rate. |
| [32](../sql/reorder_analysis/32_overall_reorder_rate.sql)) | What percentage of purchased items are reorders? | binary average | **59.01% of order-product rows** are marked as reordered. |
| [33](../sql/reorder_analysis/33_top_aisle_reorder_rates.sql)) | Which aisles have the highest reorder rates? | joins, grouped binary average, top-N | **Milk: 78.18%**, the highest aisle-level reorder rate. |
| [34](../sql/reorder_analysis/34_top_department_by_reordered_purchases.sql)) | Which department generates the most reordered purchases? | filtered CTE, joins, aggregation | **Produce: 6,432,596 reordered purchases.** This counts reorder events, not distinct products. |
| [35](../sql/reorder_analysis/35_top_reorder_products_per_department.sql)) | Which product or tied products have the highest reorder rate in each department? | multiple CTEs, partitioned `RANK` | Example: **Wheat Sandwich Bread leads bakery at 82.81%**. `RANK = 1` deliberately retains ties. |
| [36](../sql/reorder_analysis/36_top_reorder_product_min_1000.sql)) | Which sufficiently popular product has the highest reorder rate? | aggregation, `HAVING`, top-N | **Half And Half Ultra Pasteurized: 86.14%** across 2,995 purchases. The 1,000-purchase threshold reduces small-sample effects. |

## Market basket analysis

| ID | Business question | SQL techniques | Representative result and interpretation |
|---:|---|---|---|
| [37](../sql/market_basket_analysis/37_frequent_product_pairs_sample.sql)) | Which product pairs occur most often in the order-ID sample below 1,000,000? | self-join, pair canonicalization, CTE | **Bag of Organic Bananas + Organic Strawberries: 18,968 baskets.** This is a sample result, not a full-dataset estimate. |
| [38](../sql/market_basket_analysis/38_frequent_product_triples_sample.sql)) | Which triples occur most often in the order-ID sample below 10,000? | three-way self-join, tuple canonicalization, CTE | **Organic bananas + raspberries + Hass avocado: 42 baskets.** The smaller explicit sample controls triple-join growth. |
| [39](../sql/market_basket_analysis/39_adjacent_cart_product_pairs.sql)) | Which products most often appear consecutively in add-to-cart order? | `LEAD`, partitioned sequence, CTE | **Bag of Organic Bananas followed by Organic Hass Avocado: 9,940 occurrences.** This measures adjacency, not unordered co-occurrence. |
| [40](../sql/market_basket_analysis/40_products_bought_with_bananas.sql)) | Which non-banana products most often occur in banana-containing baskets? | multiple CTEs, semi-join logic, exclusion | **Organic Strawberries: 134,535 co-occurrences**, the most frequent companion product. Results are raw counts rather than lift or confidence. |

## Reproducing the results

After building the database, execute the complete validation suite:

```bash
python scripts/run_all_queries.py
```

The runner discovers queries by their two-digit IDs, verifies that IDs 01–40 occur
exactly once, and reports the runtime and status of every file.
