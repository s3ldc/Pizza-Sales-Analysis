CREATE TABLE pizza_sales
(
	pizza_id int,
	order_id int,
	piza_name_id varchar(50),
	quantity int,
	order_date date,
	order_time time,
	unit_price float,
	total_price float,
	pizza_size varchar(50),
	pizza_category varchar(50),
	pizza_ingredients varchar(200),
	pizza_name varchar(50)
)

COPY pizza_sales FROM 'C:\PostgreSQL\Pizza Outlet Analysis\pizza_sales_excel_file.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM pizza_sales;

-- The sum of the total price of all pizza orders
SELECT CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue FROM pizza_sales;

-- Average amount spent per order
SELECT CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS average_order_value FROM pizza_sales;

-- Total pizzas sold
SELECT SUM(quantity) AS total_pizza_sold FROM pizza_sales;

-- Total orders
SELECT COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales;

-- Average pizzas per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS average_pizzas_per_order FROM pizza_sales;

-- Daily trends for total orders
SELECT TO_CHAR(order_date, 'Day') AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day');

-- Monthly trends for total orders
SELECT TO_CHAR(order_date, 'Month') AS month_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Month');

-- Percentage of sales by pizza category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS percentage_of_total_sales
FROM pizza_sales
GROUP BY pizza_category;

-- Percentage of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS percentage_of_total_sales
FROM pizza_sales
GROUP BY pizza_size;

-- Total pizzas sold by pizza category
SELECT pizza_category, SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_category;

-- Top 5 by best sellers by revenue
SELECT pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Top 5 by worst sellers by revenue
SELECT pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue
LIMIT 5;

-- Top 5 by best sellers by total quantity
SELECT pizza_name, CAST(SUM(quantity) AS DECIMAL(10,2)) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC
LIMIT 5;

-- Top 5 by worst sellers by total quantity
SELECT pizza_name, CAST(SUM(quantity) AS DECIMAL(10,2)) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity
LIMIT 5;

-- Top 5 by best sellers by total orders
SELECT pizza_name, CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

-- Top 5 by worst sellers by total orders
SELECT pizza_name, CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders
LIMIT 5;