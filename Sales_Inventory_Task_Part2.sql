-- CREATE schema assignment
CREATE SCHEMA assignment;

-- CREATE Customers table in the assignment schema
CREATE TABLE assignment.customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(50),
    registration_date DATE,
    membership_status VARCHAR(10)
);
-- CREATE Products table in the assignment schema
CREATE TABLE assignment.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    supplier VARCHAR(100),
    stock_quantity INT
);
-- CREATE Sales table in the assignment schema
CREATE TABLE assignment.sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES assignment.customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES assignment.products(product_id)
);

-- CREATE Inventory table in the assignment schema
CREATE TABLE assignment.inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT,
    FOREIGN KEY (product_id) REFERENCES assignment.products(product_id)
);

-- Inserting data into assignment.Customers table
INSERT INTO assignment.Customers 
(customer_id, first_name, last_name, email, phone_number, registration_date, membership_status) 
VALUES
(1, 'Karen', 'Molina', 'gonzalezkimberly@glass.com', '(728)697-1206', '2020-08-27', 'Bronze'),
(2, 'Elizabeth', 'Archer', 'tramirez@gmail.com', '778.104.6553', '2023-08-28', 'Silver'),
(3, 'Roberta', 'Massey', 'davislori@gmail.com', '+1-365-606-7458x399', '2024-06-12', 'Bronze'),
(4, 'Jacob', 'Adams', 'andrew72@hotmail.com', '246-459-1425x462', '2023-02-10', 'Gold'),
(5, 'Cynthia', 'Lowery', 'suarezkiara@ramsey.com', '001-279-688-8177x4015', '2020-11-13', 'Silver'),
(6, 'Emily', 'King', 'igoodwin@howard.com', '(931)575-5422x5900', '2021-05-01', 'Silver'),
(7, 'Linda', 'Larsen', 'pware@yahoo.com', '289-050-2028x7673', '2021-08-20', 'Silver'),
(8, 'Angela', 'Hanson', 'zanderson@gmail.com', '+1-403-917-3585', '2023-03-17', 'Bronze'),
(9, 'Whitney', 'Wilson', 'norma70@yahoo.com', '001-594-317-6656', '2024-01-27', 'Bronze'),
(10, 'Angela', 'Atkins', 'burnsjorge@medina.org', '344.217.5788', '2025-02-05', 'Silver'),
(11, 'Gary', 'Lucero', 'ssnyder@hotmail.com', '001-842-595-7853', '2024-10-08', 'Silver'),
(12, 'Matthew', 'Romero', 'jennifer22@gmail.com', '556.328.91896', '2022-04-07', 'Bronze'),
(13, 'Ronald', 'Thompson', 'hramos@hayes.biz', '298-487-2483', '2023-07-31', 'Bronze'),
(14, 'Suzanne', 'Anderson', 'michaelcole@ruiz-ware.com', '+1-018-029-7257', '2023-11-02', 'Bronze'),
(15, 'Mary', 'Kelly', 'matthewmurphy@gmail.com', '(845)934-9x286', '2021-01-20', 'Bronze'),
(16, 'John', 'George', 'burnettlauren@gmail.com', '+1-708-200-4286', '2022-05-17', 'Bronze'),
(17, 'James', 'Rodriguez', 'brownbrian@blair-sanford.com', '8826047658', '2022-11-25', 'Gold'),
(18, 'Steven', 'Burnett', 'zblackburn@yahoo.com', '(055)912-6726x1246', '2020-01-28', 'Gold'),
(19, 'Jonathan', 'White', 'millsseth@choi-kelly.org', '755-979-1934x772', '2022-02-06', 'Bronze'),
(20, 'Christopher', 'Santiago', 'heidimaddox@hotmail.com', '118-589-6973x058', '2021-10-16', 'Silver'),
(21, 'John', 'Diaz', 'gsmith@hotmail.com', '369.915.4337', '2022-09-17', 'Gold'),
(22, 'Curtis', 'Rose', 'ryanmartinez@moore.com', '(921)461-2128', '2021-12-14', 'Bronze'),
(23, 'Charles', 'Hughes', 'jonesangela@frank-lynn.com', '(152)603-5387x8994', '2024-07-29', 'Silver'),
(24, 'Sarah', 'Cooke', 'whitedennis@tucker.org', '(641)830-6756x56741', '2024-12-15', 'Bronze'),
(25, 'Luis', 'Harrison', 'melvin70@gmail.com', '516.509.9493', '2021-08-19', 'Silver'),
(26, 'Annette', 'Greene', 'aaron68@hall.com', '(733)734-1847x1078', '2025-04-12', 'Bronze'),
(27, 'Melissa', 'Jacobson', 'becklarry@gmail.com', '562-245-7784x4729', '2023-04-28', 'Bronze'),
(28, 'Julie', 'Gardner', 'adamsrodney@hall.com', '+1-014-029-3206x188', '2024-03-31', 'Gold'),
(29, 'Margaret', 'Taylor', 'lfuller@hotmail.com', '(299)340-8900x297', '2021-09-06', 'Bronze'),
(30, 'Erika', 'Mckee', 'wsmith@gmail.com', '(160)040-7321', '2021-05-25', 'Silver'),
(31, 'Donna', 'Whitney', 'justinnicholson@gmail.com', '7086491657', '2022-08-07', 'Gold'),
(32, 'Kristina', 'Wade', 'ashley30@richards-young.com', '603-604-2831x303', '2024-03-16', 'Silver'),
(33, 'Joshua', 'Green', 'ihartman@yahoo.com', '988-232-8285x00933', '2024-05-14', 'Silver'),
(34, 'John', 'Leblanc', 'herickson@green.info', '229.016.2527x20209', '2022-12-24', 'Silver'),
(35, 'Nicholas', 'Campbell', 'ghernandez@hotmail.com', '(982)215-6626', '2022-06-06', 'Gold'),
(36, 'Christopher', 'Hicks', 'ryan48@gmail.com', '884.881.7758', '2021-04-03', 'Silver'),
(37, 'Craig', 'Miller', 'scampbell@johnson.net', '390-328-7286x021', '2024-04-30', 'Silver'),
(38, 'Jennifer', 'Bailey', 'dwright@hotmail.com', '001-992-011-9250', '2022-09-07', 'Silver'),
(39, 'Emma', 'Davis', 'lisalester@hotmail.com', '911.706.3025', '2021-06-04', 'Gold'),
(40, 'Michael', 'Wilson', 'lmerritt@wallace-wang.com', '462.021.3233', '2025-01-14', 'Bronze'),
(41, 'Sarah', 'Church', 'deniseramos@gmail.com', '(840)285-3653x61868', '2021-03-14', 'Silver'),
(42, 'Carolyn', 'Stevenson', 'george62@garrison.net', '040.179.1155', '2024-07-26', 'Silver'),
(43, 'Sarah', 'Cole', 'amandamartin@hotmail.com', '481-651-5206x4800', '2024-07-27', 'Silver'),
(44, 'Jeremiah', 'Lozano', 'bethany38@lopez.net', '846-327-7426', '2023-01-02', 'Bronze'),
(45, 'Leslie', 'Boyd', 'cartermorgan@scott-franco.com', '+1-583-786-3525', '2022-10-22', 'Silver'),
(46, 'Carrie', 'Anderson', 'stevenlivingston@yahoo.com', '+1-086-709-5530x6149', '2024-08-23', 'Gold'),
(47, 'Jared', 'Davis', 'mooretodd@cook.com', '001-069-544-8807x2397', '2022-08-29', 'Bronze'),
(48, 'James', 'Soto', 'patriciaburns@yahoo.com', '129.857.8193x421', '2023-01-27', 'Gold'),
(49, 'Cody', 'Kline', 'bradfordleslie@hotmail.com', '+1-710-706-3703x7998', '2022-06-28', 'Bronze'),
(50, 'Jennifer', 'Perkins', 'austinowens@hill.info', '762.009.1882', '2020-10-19', 'Silver');

select * from assignment.customers;

-- Inserting data into assignment.Products table
INSERT INTO assignment.Products 
(product_id, product_name, category, price, supplier, stock_quantity) 
VALUES
(1, 'Laptop', 'Electronics', 999.99, 'Dell', 50),
(2, 'Smartphone', 'Electronics', 799.99, 'Samsung', 150),
(3, 'Washing Machine', 'Appliances', 499.99, 'LG', 30),
(4, 'Headphones', 'Accessories', 199.99, 'Sony', 100),
(5, 'Refrigerator', 'Appliances', 1200.00, 'Whirlpool', 40),
(6, 'Smart TV', 'Electronics', 1500.00, 'Samsung', 20),
(7, 'Microwave', 'Appliances', 180.00, 'Panasonic', 75),
(8, 'Blender', 'Appliances', 50.00, 'Ninja', 200),
(9, 'Gaming Console', 'Electronics', 350.00, 'Sony', 60),
(10, 'Wireless Mouse', 'Accessories', 25.00, 'Logitech', 300),
(11, 'Keyboard', 'Accessories', 49.99, 'Logitech', 250),
(12, 'Monitor', 'Electronics', 250.00, 'Acer', 120),
(13, 'External Hard Drive', 'Electronics', 80.00, 'Seagate', 90),
(14, 'Tablet', 'Electronics', 400.00, 'Apple', 70),
(15, 'Smartwatch', 'Electronics', 199.99, 'Apple', 120);

select * from assignment.products;

-- Inserting data into assignment.Sales table
INSERT INTO assignment.Sales 
(sale_id, customer_id, product_id, quantity_sold, sale_date, total_amount) 
VALUES
(1, 1, 1, 1, '2023-07-15', 999.99),
(2, 2, 2, 2, '2023-08-20', 1599.98),
(3, 3, 3, 1, '2023-09-10', 499.99),
(4, 4, 4, 3, '2023-07-25', 599.97),
(5, 5, 5, 1, '2023-06-18', 1200.00),
(6, 6, 6, 1, '2023-10-05', 1500.00),
(7, 7, 7, 1, '2023-08-01', 180.00),
(8, 8, 8, 2, '2023-09-02', 100.00),
(9, 9, 9, 1, '2023-10-10', 350.00),
(10, 10, 10, 3, '2023-11-12', 75.00),
(11, 11, 11, 2, '2023-12-01', 100.00),
(12, 12, 12, 1, '2023-12-07', 250.00),
(13, 13, 13, 1, '2024-01-15', 80.00),
(14, 14, 14, 1, '2024-02-05', 400.00),
(15, 15, 15, 1, '2024-01-05', 199.99);

-- Inserting data into assignment.Inventory table
INSERT INTO assignment.inventory 
(product_id, stock_quantity) 
VALUES
(1, 50),
(2, 150),
(3, 30),
(4, 100),
(5, 40),
(6, 20),
(7, 75),
(8, 200),
(9, 60),
(10, 300),
(11, 250),
(12, 120),
(13, 90),
(14, 70),
(15, 120);

-- Select all data from assignment.Customers table
SELECT * FROM assignment.Customers;

-- Select all data from assignment.Products table
SELECT * FROM assignment.Products;

-- Select all data from assignment.Sales table
SELECT * FROM assignment.Sales;

-- Select all data from assignment.Inventory table
SELECT * FROM assignment.Inventory;

-- =====================================================
-- PART 2
-- =====================================================
-- =====================================================
-- SUBQUERY QUESTIONS
-- =====================================================

-- 51. Which customers have spent more than the average spending of all customers?
select c.customer_id, c.first_name, c.last_name,
       sum(s.total_amount) as total_spent         -- Inner query
from customers c
join sales s on c.customer_id = s.customer_id
group by c.customer_id, c.first_name, c.last_name
having sum(s.total_amount) > (select avg(customer_total)
                              from (select sum(total_amount) as customer_total
                                    from sales
                                    group by customer_id) as avg_spending);

-- 52. Which products are priced higher than the average price of all products?
select p.product_id, p.product_name, p.category, p.price
from products p  
where p.price > (select avg(price) from products);

-- 53. Which customers have never made a purchase?
select customer_id, first_name, last_name
from customers 
where customer_id not in (select customer_id from sales);

-- 54. Which products have never been sold?
select product_id, product_name, category
from products 
where product_id not in (select product_id from sales);

-- 55. Which customer made the single most expensive purchase?
select c.customer_id, c.first_name, c.last_name, s.total_amount
from customers c
join sales s on c.customer_id = s.customer_id
where s.total_amount = (select max(total_amount) from sales);

-- 56. Which products have total sales greater than the average total sales across all products?
select p.product_id, p.product_name, sum(s.total_amount) as total_sales
from products p
join sales s on p.product_id = s.product_id
group by p.product_id, p.product_name
having sum(s.total_amount) > (select avg(product_total_sales) from
                             (select sum(total_amount) as product_total_sales
                              from sales
                              group by product_id) as avg_sales);

-- 57. Which customers registered earlier than the average registration date?
select c.customer_id, c.first_name, c.last_name, sum(s.total_amount) as total_spent
from customers c
join sales s on c.customer_id = s.customer_id
group by c.customer_id, c.first_name, c.last_name, c.email
having sum(s.total_amount) > (select avg(customer_total)
                              from (select sum(total_amount) as customer_total
                                    from sales
                                    group by customer_id) as avg_spending);

-- 58. Which products have a price higher than the average price within their own category?
select p.product_id, p.product_name, p.category, p.price
from products p
where p.price > (select avg(price) 
                 from products
                 where category = p.category);

-- 59. Which customers have spent more than the customer with ID = 10?
select c.customer_id, c.first_name, c.last_name, sum(s.total_amount) as total_spent
from customers c
join sales s on c.customer_id = s.customer_id
group by c.customer_id, c.first_name, c.last_name
having sum(s.total_amount) > (select sum(total_amount) 
                              from sales
                              where customer_id = 10);

-- 60. Which products have total quantity sold greater than the overall average quantity sold?
select p.product_id, p.product_name, p.category, p.price, sum(s.quantity_sold) as total_quantity_sold
from products p
join sales s on p.product_id = s.product_id
group by p.product_id, p.product_name, p.category, p.price
having sum(s.quantity_sold) > (select avg(product_total)
                               from (select sum(quantity_sold) as product_total
                                     from sales
                                     group by product_id) as avg_quantity);

-- =====================================================
-- COMMON TABLE EXPRESSIONS (CTEs)
-- =====================================================

-- 61. Create an intermediate result that calculates the total amount spent by each customer,
--     then determine which customers are the top 5 highest spenders.
with customer_spending as (select customer_id, sum(total_amount) as total_spent
                           from sales
                           group by customer_id)
select c.customer_id, c.first_name, c.last_name, cs.total_spent
from customers c
join customer_spending cs on c.customer_id = cs.customer_id
order by cs.total_spent desc
limit 5;

-- 62. Create an intermediate result that calculates total quantity sold per product,
--     then determine which products are the top 3 most sold.
with product_quantity as (select product_id, sum(quantity_sold) as total_quantity
                          from sales
                          group by product_id)
select p.product_id, p.product_name, p.category, pq.total_quantity
from products p
join product_quantity pq on p.product_id = pq.product_id
order by pq.total_quantity desc
limit 3;

-- 63. Create an intermediate result showing total sales per product category,
--     then determine which category generates the highest revenue.
with category_revenue as (select p.category, sum(s.total_amount) as total_revenue
                          from products p
                          join sales s on p.product_id = s.product_id
                          group by p.category)
select category, total_revenue
from category_revenue
order by total_revenue desc
limit 1;

-- 64. Create an intermediate result that calculates the number of purchases per customer,
--     then identify customers who purchased more than twice.
with customer_purchases as (select customer_id, count(sale_id) as purchase_count
                            from sales
                            group by customer_id)
select c.customer_id, c.first_name, c.last_name, cp.purchase_count
from customers c
join customer_purchases cp on c.customer_id = cp.customer_id
where cp.purchase_count > 2;

-- 65. Create an intermediate result that calculates the total quantity sold per product,
--     then determine which products sold more than the average quantity sold.
with product_quantity as (select product_id, sum(quantity_sold) as total_quantity
                          from sales
                          group by product_id), avg_quantity as (select avg(total_quantity) as avg_qty
                                                                 from product_quantity)
select p.product_id, p.product_name, pq.total_quantity
from products p
join product_quantity pq on p.product_id = pq.product_id
cross join avg_quantity
where pq.total_quantity > avg_quantity.avg_qty;

-- 66. Create an intermediate result that calculates total spending per customer,
--     then determine which customers spent more than the average spending.
with customer_spending as (select customer_id, sum(total_amount) as total_spent
                           from sales
                           group by customer_id), avg_spending as (select avg(total_spent) as avg_spent
                                                                   from customer_spending)
select c.customer_id, c.first_name, c.last_name, cs.total_spent
from customers c
join customer_spending cs on c.customer_id = cs.customer_id
cross join avg_spending
where cs.total_spent > avg_spending.avg_spent;

-- 67. Create an intermediate result that calculates total revenue per product,
--     then list the products ordered from highest revenue to lowest.
with product_revenue as (select product_id, sum(total_amount) as total_revenue
                         from sales
                         group by product_id)
select p.product_id, p.product_name, p.category, pr.total_revenue
from products p
join product_revenue pr on p.product_id = pr.product_id
order by pr.total_revenue desc;

-- 68. Create an intermediate result showing monthly sales totals, then determine which month had the highest revenue.
with monthly_sales as (select
        to_char(sale_date, 'yyyy-mm') as sale_month,
        sum(total_amount) as total_revenue
    from sales
    group by to_char(sale_date, 'yyyy-mm'))
select sale_month, total_revenue
from monthly_sales
order by total_revenue desc
limit 1;

-- 69. Create an intermediate result that calculates the number of sales per product,
--     then determine which products were purchased by more than three customers.
with product_sales_count as (select product_id, count(distinct customer_id) as customer_count
                             from sales
                             group by product_id)
select p.product_id, p.product_name, p.category, ps.customer_count
from products p
join product_sales_count ps on p.product_id = ps.product_id
where ps.customer_count > 3;

-- 70. Create an intermediate result showing total quantity sold per product,
--     then identify products that sold less than the average quantity sold.
with product_quantity as (select product_id, sum(quantity_sold) as total_quantity
                          from sales
                          group by product_id), avg_quantity as (select avg(total_quantity) as avg_qty
                                                                 from product_quantity)
select p.product_id, p.product_name, p.category, pq.total_quantity
from products p
join product_quantity pq on p.product_id = pq.product_id
cross join avg_quantity
where pq.total_quantity < avg_quantity.avg_qty;


-- =====================================================
-- WINDOW FUNCTION QUESTIONS
-- =====================================================

-- 71. Rank customers based on the total amount they have spent.
select c.customer_id, c.first_name, c.last_name, sum(s.total_amount) as total_spent,
       rank() over (order by sum(s.total_amount) desc) as spending_rank
from customers c
join sales s on c.customer_id = s.customer_id
group by c.customer_id, c.first_name, c.last_name;

-- 72. Rank products based on total quantity sold.
select p.product_id, product_name, sum(s.quantity_sold) as total_quantity,
       rank() over (order by sum(quantity_sold) desc) as quantity_rank
from products p
join sales s on p.product_id = s.product_id
group by p.product_id, product_name;

-- 73. Identify the 3rd highest spending customer.
with customer_spending as (select c.customer_id, c.first_name, c.last_name, sum(s.total_amount) as total_spent,
     dense_rank() over (order by sum(s.total_amount) desc) as spending_rank
     from customers c
     join sales s on c.customer_id = s.customer_id
     group by c.customer_id, c.first_name, c.last_name)
select customer_id, first_name, last_name, total_spent, spending_rank
from customer_spending
where spending_rank = 3;

-- 74. Identify the 2nd most expensive product.
with product_pricing as (select product_id, product_name, category, price,
     dense_rank() over (order by price desc) as price_rank
     from products)
select product_id, product_name, category, price, price_rank
from product_pricing
where price_rank = 2;

-- 75. Show the ranking of products within each category based on price.
select product_id, product_name, category, price,
       rank() over (partition by category order by price desc) as price_rank_in_category
from products;

-- 76. Show the ranking of customers based on the number of purchases they made.
select c.customer_id, c.first_name, c.last_name, count(s.sale_id) as number_of_purchases,
       rank() over (order by count(s.sale_id) desc) as purchase_rank
from customers c
join sales s on c.customer_id = s.customer_id
group by c.customer_id, c.first_name, c.last_name;

-- 77. Show the running total of sales amounts ordered by sale_date.
select sale_id, customer_id, product_id, sale_date, total_amount,
       sum(total_amount) over (order by sale_date 
                            rows between unbounded preceding and current row
                           ) as running_total
from sales
order by sale_date;

-- 78. Show the previous sale amount for each sale ordered by sale_date.
select sale_id, customer_id, product_id, sale_date, total_amount,
       lag(total_amount, 1) over (order by sale_date) as previous_sale_amount
from sales
order by sale_date;

-- 79. Show the next sale amount for each sale ordered by sale_date.
select sale_id, customer_id, product_id, sale_date, total_amount,
       lead(total_amount, 1) over (order by sale_date) as next_sale_amount
from sales
order by sale_date;

-- 80. Divide customers into 4 groups based on total spending.
with customer_spending as (select customer_id, sum(total_amount) as total_spent
                           from sales
                           group by customer_id)
select c.customer_id, c.first_name, c.last_name, cs.total_spent,
       ntile(4) over (order by cs.total_spent desc) as spending_group
from customers c
join customer_spending cs on c.customer_id = cs.customer_id;

-- =====================================================
-- ADVANCED ANALYTICAL QUESTIONS
-- =====================================================

-- 81. Which customers bought products in more than one category?
select c.customer_id, c.first_name, c.last_name, count(distinct p.category) as categories_purchased
from customers c
join sales s on c.customer_id = s.customer_id
join products p on s.product_id = p.product_id
group by c.customer_id, c.first_name, c.last_name
having count(distinct p.category) > 1;

-- 82. Which customers purchased products within 7 days of registering?
select distinct c.customer_id, c.first_name, c.last_name, c.registration_date, s.sale_date,
       (s.sale_date - c.registration_date) as days_after_registration
from customers c
join sales s on c.customer_id = s.customer_id
where s.sale_date between c.registration_date 
                      and c.registration_date + interval '7 days'
order by days_after_registration;

-- 83. Which products have lower stock remaining than the average stock quantity?
with avg_stock as (
    select avg(stock_quantity) as avg_qty
    from inventory)
select p.product_id, p.product_name, p.category, i.stock_quantity,
    round(av.avg_qty, 2) as avg_stock_quantity
from products p
join inventory i on p.product_id = i.product_id
cross join avg_stock av
where i.stock_quantity < av.avg_qty
order by i.stock_quantity asc;

-- 84. Which customers purchased the same product more than once?
select c.customer_id, c.first_name, c.last_name, p.product_id, p.product_name,
       count(s.sale_id) as times_purchased
from customers c
join sales s on c.customer_id = s.customer_id
join products p on s.product_id = p.product_id
group by c.customer_id, c.first_name, c.last_name, p.product_id, p.product_name
having count(s.sale_id) > 1
order by times_purchased desc;

-- 85. Which product categories generated the highest total revenue?
select p.category, sum(s.total_amount) as total_revenue,
       rank() over (order by sum(s.total_amount) desc) as revenue_rank
from sales s
join products p on s.product_id = p.product_id
group by p.category
order by total_revenue desc;

-- 86. Which products are among the top 3 most sold products?
with product_sales as (select product_id, sum(quantity_sold) as total_quantity,
        dense_rank() over (order by sum(quantity_sold) desc) as sales_rank
        from sales
        group by product_id)
select p.product_id, p.product_name, p.category, ps.total_quantity, ps.sales_rank
from products p
join product_sales ps on p.product_id = ps.product_id
where ps.sales_rank <= 3
order by ps.sales_rank;

-- 87. Which customers purchased the most expensive product?
select distinct c.customer_id, c.first_name, c.last_name, p.product_name, p.price
from customers c
join sales s on c.customer_id = s.customer_id
join products p on s.product_id = p.product_id
where p.price = (select max(price)
                 from products);

-- 88. Which products were purchased by the highest number of unique customers?
with product_unique_customers as (select product_id, count(distinct customer_id) as unique_customers,
        dense_rank() over (order by count(distinct customer_id) desc) as customer_rank
    from sales
    group by product_id)
select p.product_id, p.product_name, p.category, puc.unique_customers
from products p
join product_unique_customers puc on p.product_id = puc.product_id
where puc.customer_rank = 1
order by puc.unique_customers desc;

-- 89. Which customers made purchases above the average sale amount?
select distinct c.customer_id, c.first_name, c.last_name, s.total_amount,
        round((select avg(total_amount) from sales), 2) as avg_sale_amount
from customers c
join sales s on c.customer_id = s.customer_id
where s.total_amount > (select avg(total_amount)
                        from sales)
order by s.total_amount desc;

-- 90. Which customers purchased more products than the average quantity purchased per customer?
with customer_quantity as (select customer_id, sum(quantity_sold) as total_quantity
                           from sales
                           group by customer_id), avg_quantity as (select avg(total_quantity) as avg_qty
                                                                   from customer_quantity)
select c.customer_id, c.first_name, c.last_name, cq.total_quantity, round(aq.avg_qty, 2) as avg_quantity
from customers c
join customer_quantity cq on c.customer_id = cq.customer_id
cross join avg_quantity aq
where cq.total_quantity > aq.avg_qty
order by cq.total_quantity desc;

-- =====================================================
-- ADVANCED WINDOW + ANALYTICAL PROBLEMS
-- =====================================================

-- 91. Which customers rank in the top 10% of spending?
with customer_spending as (select c.customer_id, c.first_name, c.last_name, 
        sum(s.total_amount) as total_spent,
        ntile(10) over (order by sum(s.total_amount) desc) as spending_percentile
        from customers c
        join sales s on c.customer_id = s.customer_id
        group by c.customer_id, c.first_name, c.last_name)
select customer_id, first_name, last_name, total_spent, spending_percentile
from customer_spending
where spending_percentile = 1
order by total_spent desc;

-- 92. Which products contribute to the top 50% of total revenue?
with product_revenue as (select p.product_id, p.product_name, p.category,
        sum(s.total_amount) as total_revenue
        from sales s
        join products p on s.product_id = p.product_id
        group by p.product_id, p.product_name, p.category),
revenue_cumulative as (select product_id, product_name, category, total_revenue,
        sum(total_revenue) over (order by total_revenue desc
                                 rows between unbounded preceding 
                                 and current row) as cumulative_revenue,
        sum(total_revenue) over () as grand_total_revenue
    from product_revenue)
select product_id, product_name, category, total_revenue, 
       round(cumulative_revenue, 2) as cumulative_revenue, 
       round((cumulative_revenue / grand_total_revenue) * 100, 2) as cumulative_percentage
from revenue_cumulative
where (cumulative_revenue - total_revenue) / grand_total_revenue < 0.50
order by total_revenue desc;

-- 93. Which customers made purchases in consecutive months?
WITH customer_months AS (SELECT DISTINCT customer_id,
        TO_CHAR(sale_date, 'YYYY-MM') AS sale_month,
        DATE_TRUNC('month', sale_date) AS month_start
    FROM sales),
month_gaps AS (SELECT customer_id, sale_month, month_start,
        LAG(month_start) OVER (PARTITION BY customer_id 
                                ORDER BY month_start) AS prev_month_start
    FROM customer_months)
SELECT DISTINCT c.customer_id, c.first_name, c.last_name, mg.prev_month_start AS first_consecutive_month,
       mg.sale_month AS second_consecutive_month
FROM customers c
JOIN month_gaps mg ON c.customer_id = mg.customer_id
WHERE mg.month_start = mg.prev_month_start + INTERVAL '1 month'
ORDER BY c.customer_id;

-- 94. Which products experienced the largest difference between stock quantity and total quantity sold?
with product_sales as (select product_id, sum(quantity_sold) as total_sold
    from sales
    group by product_id),
stock_vs_sold as (select p.product_id, p.product_name, p.category, i.stock_quantity,
        coalesce(ps.total_sold, 0) as total_sold,
        abs(i.stock_quantity - coalesce(ps.total_sold, 0)) as stock_difference
    from products p
    join inventory i on p.product_id = i.product_id
    left join product_sales ps on p.product_id = ps.product_id)
select product_id, product_name, category, stock_quantity, total_sold, stock_difference,
    rank() over (order by stock_difference desc) as difference_rank
from stock_vs_sold
order by stock_difference desc;

-- 95. Which customers have spending above the average spending of their membership tier?
with customer_spending as (select c.customer_id, c.first_name, c.last_name, c.membership_status,
        sum(s.total_amount) as total_spent
    from customers c
    join sales s on c.customer_id = s.customer_id
    group by c.customer_id, c.first_name, c.last_name, c.membership_status),
tier_avg as (select membership_status, avg(total_spent) as avg_spent_in_tier
    from customer_spending
    group by membership_status)
select cs.customer_id, cs.first_name, cs.last_name, cs.membership_status, cs.total_spent,
    round(ta.avg_spent_in_tier, 2) as tier_average
from customer_spending cs
join tier_avg ta on cs.membership_status = ta.membership_status
where cs.total_spent > ta.avg_spent_in_tier
order by cs.membership_status, cs.total_spent desc;

-- 96. Which products have higher sales than the average sales within their category?
with product_sales as (select p.product_id, p.product_name, p.category,
        sum(s.total_amount) as total_revenue
    from sales s
    join products p on s.product_id = p.product_id
    group by p.product_id, p.product_name, p.category),
category_avg as (select category, avg(total_revenue) as avg_category_revenue
    from product_sales
    group by category)
select ps.product_id, ps.product_name, ps.category, ps.total_revenue,
    round(ca.avg_category_revenue, 2) as category_average
from product_sales ps
join category_avg ca on ps.category = ca.category
where ps.total_revenue > ca.avg_category_revenue
order by ps.category, ps.total_revenue desc;

-- 97. Which customer made the largest single purchase relative to their total spending?
with customer_totals as (select customer_id, sum(total_amount) as total_spent
    from sales
    group by customer_id),
purchase_ratio as (select s.sale_id, s.customer_id, s.sale_date, s.total_amount as single_purchase, ct.total_spent,
        round((s.total_amount / ct.total_spent) * 100, 2) as purchase_percentage,
        rank() over (order by (s.total_amount / ct.total_spent) desc) as ratio_rank
    from sales s
    join customer_totals ct on s.customer_id = ct.customer_id)
select c.customer_id, c.first_name, c.last_name, pr.sale_id, pr.single_purchase, pr.total_spent,
    pr.purchase_percentage as pct_of_total_spending
from customers c
join purchase_ratio pr on c.customer_id = pr.customer_id
where pr.ratio_rank = 1;

-- 98. Which products rank among the top 3 most sold products within each category?
with category_product_sales as (select p.product_id, p.product_name, p.category,
        sum(s.quantity_sold) as total_quantity,
        dense_rank() over (partition by p.category 
                           order by sum(s.quantity_sold) desc) as category_rank
    from sales s
    join products p on s.product_id = p.product_id
    group by p.product_id, p.product_name, p.category)
select product_id, product_name, category, total_quantity, category_rank
from category_product_sales
where category_rank <= 3
order by category, category_rank;

-- 99. Which customers are tied for the highest total spending?
with customer_spending as (select c.customer_id, c.first_name, c.last_name,
        sum(s.total_amount) as total_spent,
        dense_rank() over (order by sum(s.total_amount) desc) as spending_rank
    from customers c
    join sales s on c.customer_id = s.customer_id
    group by c.customer_id, c.first_name, c.last_name)
select customer_id, first_name, last_name, total_spent, spending_rank
from customer_spending
where spending_rank = 1;

-- 100. Which products generated sales every year present in the dataset?
with yearly_sales as (select distinct product_id,
        extract(year from sale_date) as sale_year
    from sales),
total_years as (select count(distinct extract(year from sale_date)) as num_years
    from sales)
select p.product_id, p.product_name, p.category, count(ys.sale_year) as years_with_sales
from products p
join yearly_sales ys on p.product_id = ys.product_id
cross join total_years ty
group by p.product_id, p.product_name, p.category, ty.num_years
having count(ys.sale_year) = ty.num_years
order by p.product_id;
