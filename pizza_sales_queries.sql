
USE pizza_sales;

-- 1. Total pizzas sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM order_details;

-- 2. Monthly orders
SELECT DATE_FORMAT(STR_TO_DATE(`date`, '%d-%m-%Y'), '%Y-%m') AS month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- 3. Revenue by category
SELECT pt.category,
       ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY revenue DESC;

-- 4. Top 5 pizzas by revenue
SELECT pt.name,
       ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 5;

-- 5. Sales by pizza size
SELECT p.size,
       ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY revenue DESC;

-- 6. Orders by weekday
SELECT DAYNAME(STR_TO_DATE(`date`, '%d-%m-%Y')) AS weekday,
       COUNT(*) AS total_orders
FROM orders
GROUP BY weekday
ORDER BY total_orders DESC;

-- 7. Average pizza price
SELECT ROUND(AVG(price), 2) AS avg_pizza_price
FROM pizzas;
