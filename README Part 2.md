# 📊 SQL Key Insights — Subqueries, CTEs, Window Functions & Advanced Analytics

A comprehensive reference guide covering SQL concepts from foundational subqueries to advanced window functions, built around a retail dataset with four core tables: `customers`, `products`, `sales`, and `inventory`.

---

## 🗂️ Dataset Schema

```sql
customers  → customer_id, first_name, last_name, email, phone_number, registration_date, membership_status
products   → product_id, product_name, category, price, supplier, stock_quantity
sales      → sale_id, customer_id, product_id, quantity_sold, sale_date, total_amount
inventory  → product_id, stock_quantity
```

---

## 📌 Table of Contents

1. [Subqueries](#1-subqueries)
2. [Common Table Expressions (CTEs)](#2-common-table-expressions-ctes)
3. [Window Functions](#3-window-functions)
4. [Advanced Analytical SQL](#4-advanced-analytical-sql)
5. [Advanced Window + Analytical Problems](#5-advanced-window--analytical-problems)
6. [PostgreSQL vs MySQL Syntax Reference](#6-postgresql-vs-mysql-syntax-reference)

---

## 1. Subqueries

A **subquery** is a query nested inside another query. It runs first and passes its result to the outer query.

### 1.1 Single-Level Subquery (Scalar)

Used when comparing a row-level value directly against a single result — no grouping needed.

```sql
-- Customers who registered before the average registration date
SELECT customer_id, first_name, last_name, registration_date
FROM customers
WHERE registration_date < (
    SELECT AVG(registration_date)
    FROM customers
);
```

> **Key insight:** `WHERE` is appropriate here because we are filtering on a non-aggregated column (`registration_date`). The subquery returns a single scalar value that every row is compared against.

---

### 1.2 Two-Level Nested Subquery

Required when averaging aggregated results. `AVG(SUM())` is **not directly valid** in SQL, so a nested approach is needed.

```sql
-- Customers who spent more than the average spending of all customers
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.total_amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(total_amount) AS customer_total   -- Inner: total per customer
        FROM sales
        GROUP BY customer_id
    ) AS avg_spending                                 -- Outer: average of those totals
);
```

> **Key insight:** `HAVING` (not `WHERE`) filters on aggregated values like `SUM()`. `WHERE` runs before grouping and cannot reference aggregate functions.

---

### 1.3 Subquery Comparison Against a Specific Value

```sql
-- Customers who spent more than customer ID 10
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.total_amount) > (
    SELECT COALESCE(SUM(total_amount), 0)
    FROM sales
    WHERE customer_id = 10
);
```

> **Key insight:** `COALESCE` safely handles the case where the reference customer has no sales — without it, the subquery returns `NULL` and no rows are returned from the outer query.

---

### 1.4 WHERE vs HAVING — Quick Reference

| Clause | Runs | Use For |
|--------|------|---------|
| `WHERE` | Before grouping | Filtering on raw, non-aggregated columns |
| `HAVING` | After grouping | Filtering on aggregated values like `SUM()`, `COUNT()`, `AVG()` |

---

## 2. Common Table Expressions (CTEs)

A **CTE** defines a named temporary result set using `WITH`, making complex queries more readable and reusable.

### 2.1 Single CTE

```sql
-- Top 5 highest spending customers
WITH customer_spending AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM sales
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, cs.total_spent
FROM customers c
JOIN customer_spending cs ON c.customer_id = cs.customer_id
ORDER BY cs.total_spent DESC
LIMIT 5;
```

---

### 2.2 Multiple CTEs (Chained)

Used when a second computation depends on the result of the first — avoiding deeply nested subqueries.

```sql
-- Products that sold more than the average quantity sold
WITH product_quantity AS (
    SELECT product_id, SUM(quantity_sold) AS total_quantity
    FROM sales
    GROUP BY product_id
),
avg_quantity AS (
    SELECT AVG(total_quantity) AS avg_qty        -- Builds on first CTE
    FROM product_quantity
)
SELECT p.product_id, p.product_name, pq.total_quantity
FROM products p
JOIN product_quantity pq ON p.product_id = pq.product_id
CROSS JOIN avg_quantity aq
WHERE pq.total_quantity > aq.avg_qty;
```

---

### 2.3 CROSS JOIN for Scalar Averages

When a CTE returns a **single row** (like an average), `CROSS JOIN` brings that value into every row of the main query for comparison — without collapsing the result set.

```sql
CROSS JOIN avg_quantity aq
WHERE pq.total_quantity > aq.avg_qty   -- Compare every product against the single average
```

> **Key insight:** `CROSS JOIN` on a single-row CTE is equivalent to referencing a constant — it adds the average column to every row, allowing it to be used in both `WHERE` filters and `SELECT` for display.

---

### 2.4 CTE vs Subquery — When to Use Which

| Approach | Best Used When |
|----------|---------------|
| Subquery | Simple one-time scalar comparison |
| Single CTE | One intermediate result needed, improves readability |
| Multiple CTEs | Second computation depends on first; replaces nested subqueries |
| CTE + CROSS JOIN | Reusing a scalar value in both `SELECT` and `WHERE` |

---

## 3. Window Functions

**Window functions** perform calculations across a set of rows related to the current row — without collapsing rows like `GROUP BY` does.

```sql
function_name() OVER (
    PARTITION BY column    -- Optional: resets calculation per group
    ORDER BY column        -- Defines row ordering within the window
    ROWS BETWEEN ...       -- Optional: defines the frame
)
```

---

### 3.1 Ranking Functions

| Function | Behaviour | Example Output | Use Case |
|----------|-----------|----------------|----------|
| `RANK()` | Skips ranks after ties | 1, 1, 3, 4 | General leaderboards |
| `DENSE_RANK()` | No gaps after ties | 1, 1, 2, 3 | When filtering by exact rank position |
| `NTILE(n)` | Splits rows into n equal buckets | 1, 1, 2, 2, 3... | Percentile grouping |
| `ROW_NUMBER()` | Unique sequential number, no ties | 1, 2, 3, 4 | Deduplication, pagination |

```sql
-- Rank customers by total spending
SELECT
    c.customer_id, c.first_name, c.last_name,
    SUM(s.total_amount) AS total_spent,
    RANK()       OVER (ORDER BY SUM(s.total_amount) DESC) AS rank_with_gaps,
    DENSE_RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS rank_no_gaps
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
```

> **Key insight:** Always use `DENSE_RANK()` when filtering by a specific rank position (e.g., `WHERE rank = 3`). With `RANK()`, a tie at position 2 skips rank 3, causing valid rows to be excluded entirely.

---

### 3.2 PARTITION BY — Within-Group Rankings

`PARTITION BY` resets the window function independently for each group, giving each partition its own rank sequence starting from 1.

```sql
-- Rank products within each category by price
SELECT
    product_id, product_name, category, price,
    DENSE_RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank_in_category
FROM products;
```

> **Key insight:** Without `PARTITION BY`, all rows share one ranking. With `PARTITION BY category`, each category gets its own independent ranking — the most powerful combination for within-group analysis.

---

### 3.3 LAG and LEAD — Accessing Adjacent Rows

```sql
-- Previous and next sale amounts
SELECT
    sale_id, sale_date, total_amount,
    LAG(total_amount, 1)  OVER (ORDER BY sale_date) AS previous_sale,  -- looks back
    LEAD(total_amount, 1) OVER (ORDER BY sale_date) AS next_sale        -- looks forward
FROM sales;
```

> **Key insight:** The first row's `LAG` and the last row's `LEAD` always return `NULL` — there is no preceding or following row. Use `COALESCE(LAG(...), 0)` to substitute a default value if needed.

---

### 3.4 Running Total with Window Frame

```sql
-- Cumulative sales total ordered by date
SELECT
    sale_id, sale_date, total_amount,
    SUM(total_amount) OVER (
        ORDER BY sale_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM sales;
```

> **Key insight:** `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` explicitly defines the window frame — summing all rows from the very first record up to and including the current row. This is the standard definition of a running total.

---

### 3.5 NTILE — Percentile Bucketing

```sql
-- Divide customers into 4 spending groups (quartiles)
WITH customer_spending AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM sales GROUP BY customer_id
)
SELECT
    c.customer_id, c.first_name, c.last_name,
    cs.total_spent,
    NTILE(4) OVER (ORDER BY cs.total_spent DESC) AS spending_quartile
FROM customers c
JOIN customer_spending cs ON c.customer_id = cs.customer_id;
```

> **Key insight:** `NTILE(10)` splits customers into 10 equal buckets where bucket 1 = top 10%. This is a clean alternative to calculating exact percentile thresholds manually with `PERCENT_RANK()`.

---

## 4. Advanced Analytical SQL

### 4.1 Multi-Table JOINs with DISTINCT

`DISTINCT` eliminates duplicate customer rows that appear when a customer has multiple matching sales records.

```sql
-- Customers who purchased the most expensive product
SELECT DISTINCT
    c.customer_id, c.first_name, c.last_name,
    p.product_name, p.price
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN products p ON s.product_id = p.product_id
WHERE p.price = (SELECT MAX(price) FROM products);
```

---

### 4.2 Date Arithmetic (PostgreSQL)

```sql
-- Customers who purchased within 7 days of registering
SELECT DISTINCT
    c.customer_id, c.first_name, c.last_name,
    c.registration_date, s.sale_date,
    (s.sale_date - c.registration_date) AS days_after_registration
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_date BETWEEN c.registration_date
                      AND c.registration_date + INTERVAL '7 days';
```

> **Key insight:** PostgreSQL supports direct date subtraction — `sale_date - registration_date` returns the number of days as an integer. `BETWEEN` is inclusive on both ends, so day 0 (same day as registration) and day 7 are both included.

---

### 4.3 Detecting Consecutive Months (PostgreSQL)

```sql
WITH customer_months AS (
    SELECT DISTINCT customer_id,
        TO_CHAR(sale_date, 'YYYY-MM') AS sale_month,
        DATE_TRUNC('month', sale_date) AS month_start
    FROM sales
),
month_gaps AS (
    SELECT customer_id, sale_month, month_start,
        LAG(month_start) OVER (PARTITION BY customer_id ORDER BY month_start) AS prev_month_start
    FROM customer_months
)
SELECT DISTINCT c.customer_id, c.first_name, c.last_name,
    mg.prev_month_start AS first_consecutive_month,
    mg.sale_month       AS second_consecutive_month
FROM customers c
JOIN month_gaps mg ON c.customer_id = mg.customer_id
WHERE mg.month_start = mg.prev_month_start + INTERVAL '1 month';
```

> **Key insight:** `DATE_TRUNC('month', sale_date)` normalises all dates to the 1st of the month, making arithmetic clean and reliable. Adding `INTERVAL '1 month'` handles year-boundary rollovers (December → January) automatically — no special case needed.

---

### 4.4 COALESCE for NULL Safety

```sql
-- Stock difference: handles products with no sales
ABS(i.stock_quantity - COALESCE(ps.total_sold, 0)) AS stock_difference
```

> **Key insight:** `COALESCE` replaces `NULL` with a fallback value. Products with no sales records return `NULL` from a `LEFT JOIN` — subtracting `NULL` from any number produces `NULL`, silently breaking calculations.

---

### 4.5 Within-Tier Comparisons

```sql
-- Customers spending above their own membership tier's average
WITH customer_spending AS (
    SELECT c.customer_id, c.first_name, c.last_name,
           c.membership_status, SUM(s.total_amount) AS total_spent
    FROM customers c JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.membership_status
),
tier_avg AS (
    SELECT membership_status, AVG(total_spent) AS avg_spent_in_tier
    FROM customer_spending
    GROUP BY membership_status
)
SELECT cs.customer_id, cs.first_name, cs.membership_status,
       cs.total_spent, ROUND(ta.avg_spent_in_tier, 2) AS tier_average
FROM customer_spending cs
JOIN tier_avg ta ON cs.membership_status = ta.membership_status
WHERE cs.total_spent > ta.avg_spent_in_tier
ORDER BY cs.membership_status, cs.total_spent DESC;
```

> **Key insight:** Joining on `membership_status` ensures each customer is compared only against the average of their own tier — not the global average. This pattern applies to any group-relative comparison.

---

## 5. Advanced Window + Analytical Problems

### 5.1 Top N% with NTILE

```sql
-- Top 10% of spenders
WITH customer_spending AS (
    SELECT c.customer_id, c.first_name, c.last_name,
           SUM(s.total_amount) AS total_spent,
           NTILE(10) OVER (ORDER BY SUM(s.total_amount) DESC) AS spending_percentile
    FROM customers c JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT * FROM customer_spending
WHERE spending_percentile = 1;
```

---

### 5.2 Cumulative Revenue (Top 50% of Products)

```sql
WITH product_revenue AS (...),
revenue_cumulative AS (
    SELECT product_id, product_name, total_revenue,
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC
                                 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue,
        SUM(total_revenue) OVER () AS grand_total_revenue
    FROM product_revenue
)
SELECT *
FROM revenue_cumulative
WHERE (cumulative_revenue - total_revenue) / grand_total_revenue < 0.50;
```

> **Key insight:** The filter `(cumulative_revenue - total_revenue) / grand_total_revenue < 0.50` checks the cumulative total *before* the current row is added. This prevents a product from being cut off mid-threshold if adding it would push the cumulative total just over 50%.

---

### 5.3 Top N Within Each Category

```sql
-- Top 3 most sold products per category
WITH category_product_sales AS (
    SELECT p.product_id, p.product_name, p.category,
           SUM(s.quantity_sold) AS total_quantity,
           DENSE_RANK() OVER (PARTITION BY p.category
                              ORDER BY SUM(s.quantity_sold) DESC) AS category_rank
    FROM sales s JOIN products p ON s.product_id = p.product_id
    GROUP BY p.product_id, p.product_name, p.category
)
SELECT * FROM category_product_sales
WHERE category_rank <= 3
ORDER BY category, category_rank;
```

> **Key insight:** `PARTITION BY category` + `DENSE_RANK()` is the most powerful combination for within-group rankings. Each category gets its own independent rank sequence, and `DENSE_RANK` ensures no rank positions are skipped due to ties.

---

### 5.4 Dynamic Year Counting

```sql
-- Products with sales in every year in the dataset
WITH yearly_sales AS (
    SELECT DISTINCT product_id, EXTRACT(YEAR FROM sale_date) AS sale_year
    FROM sales
),
total_years AS (
    SELECT COUNT(DISTINCT EXTRACT(YEAR FROM sale_date)) AS num_years
    FROM sales
)
SELECT p.product_id, p.product_name, COUNT(ys.sale_year) AS years_with_sales
FROM products p
JOIN yearly_sales ys ON p.product_id = ys.product_id
CROSS JOIN total_years ty
GROUP BY p.product_id, p.product_name, ty.num_years
HAVING COUNT(ys.sale_year) = ty.num_years;
```

> **Key insight:** The `total_years` CTE counts distinct years dynamically from the data itself. Hardcoding `HAVING COUNT(...) = 3` silently breaks when new years are added to the dataset — the dynamic approach self-adjusts automatically.

---

## 6. PostgreSQL vs MySQL Syntax Reference

A quick-reference for queries that behave differently across databases.

### Date Formatting

| Operation | PostgreSQL ✅ | MySQL |
|-----------|-------------|-------|
| Format as `YYYY-MM` | `TO_CHAR(sale_date, 'YYYY-MM')` | `DATE_FORMAT(sale_date, '%Y-%m')` |
| Extract year | `EXTRACT(YEAR FROM sale_date)` | `YEAR(sale_date)` |
| Truncate to month | `DATE_TRUNC('month', sale_date)` | `DATE_FORMAT(sale_date, '%Y-%m-01')` |
| Add 7 days | `date + INTERVAL '7 days'` | `DATE_ADD(date, INTERVAL 7 DAY)` |
| Subtract dates | `date1 - date2` → integer days | `DATEDIFF(date1, date2)` |

### Limiting Results

| Operation | PostgreSQL ✅ | SQL Server |
|-----------|-------------|------------|
| Top N rows | `LIMIT 5` | `TOP 5` (in `SELECT`) |

### Type Casting

```sql
-- PostgreSQL explicit cast
AVG(registration_date::date)
-- or
CAST(registration_date AS date)
```

---

## 🔑 Master Cheat Sheet

```
SUBQUERIES
├── Scalar subquery in WHERE    → single value comparison, no grouping
├── HAVING + subquery           → filter on aggregated results (SUM, COUNT)
├── Two-level nested subquery   → AVG(SUM()) pattern requires nesting
└── COALESCE in subquery        → safely handle NULL when reference row missing

CTEs
├── Single CTE                  → one intermediate result, cleaner than subquery
├── Multiple CTEs               → chain computations, second builds on first
└── CROSS JOIN scalar CTE       → bring single average value into every row

WINDOW FUNCTIONS
├── RANK()                      → gaps after ties (1,1,3)
├── DENSE_RANK()                → no gaps (1,1,2) — use when filtering by rank
├── NTILE(n)                    → split into n equal buckets
├── PARTITION BY                → independent ranking per group
├── LAG / LEAD                  → access previous / next row values
├── ROWS BETWEEN UNBOUNDED      → defines running total window frame
│   PRECEDING AND CURRENT ROW
└── SUM() OVER ()               → grand total across all rows (no ORDER BY)

DATE FUNCTIONS (PostgreSQL)
├── TO_CHAR(date, 'YYYY-MM')    → format as year-month string
├── DATE_TRUNC('month', date)   → normalize to first of month
├── EXTRACT(YEAR FROM date)     → extract year as number
└── date + INTERVAL '1 month'  → safe month arithmetic, handles year rollover
```

---

*Built with PostgreSQL. All queries tested against the `customers`, `products`, `sales`, and `inventory` tables.*
