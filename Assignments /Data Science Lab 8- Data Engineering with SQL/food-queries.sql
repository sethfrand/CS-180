

-- #### SECTION 1: Special Operators ####

-- Q1) Find the names of all juice items (menu table).

-- Write your query here:

select menu_name from Menu where menu_name like '%juice%' or menu_name like '%fruit%';


-- Paste your resulting table here:
-- menu_name
--Passion Fruit
--Mango Juice
--Orange Juice


-- Q2) Find all orders (order table) between August 1 and 9, 2022

Select * from orders where orderdate between '2022-08-01' and '2022-08-09'
LIMIT 5;


--resulting table

-- orderid	orderdate	menu_id	quantity	customer_id	delivery_platform	emp_id
-- 1	2022-08-01	1	1	4	Grabfood	1
-- 2	2022-08-01	6	2	1	Lineman	1
-- 3	2022-08-02	2	2	2	Robinhood	2
-- 4	2022-08-03	3	1	5	Grabfood	3
-- 5	2022-08-04	1	1	2	Robinhood	2

-- Q3) Find the orders (order table) where the delivery platform contains the substring 'ood'

SELECT * from orders where delivery_platform like '%ood'
limit 5;

--resulting table
-- orderid	orderdate	menu_id	quantity	customer_id	delivery_platform	emp_id
-- 1	2022-08-01	1	1	4	Grabfood	1
-- 3	2022-08-02	2	2	2	Robinhood	2
-- 4	2022-08-03	3	1	5	Grabfood	3
-- 5	2022-08-04	1	1	2	Robinhood	2
-- 6	2022-08-05	6	1	4	Grabfood	1

-- Q4) Find the unique delivery order companies from the order table. Get only the name, no other data.

SELECT  DISTINCT delivery_platform from orders
limit 5;


--resulting table

--delivery_platform
--Grabfood
--Lineman
--Robinhood

-- Q5) Sort the orders table by quantity, largest to smallest

select * from orders order by quantity desc
limit 5; 

--resulting table
--orderid	orderdate	menu_id	quantity	customer_id	delivery_platform	emp_id
-- 9	2022-08-13	5	3	1	Lineman	1
-- 19	2022-08-26	5	3	3	Grabfood	3
-- 2	2022-08-01	6	2	1	Lineman	1
-- 3	2022-08-02	2	2	2	Robinhood	2
-- 8	2022-08-09	3	2	4	Grabfood	1


-- #### SECTION 2: Functions ####

-- Q6) Find minimum, maximum, and average unit price from the menu table (run as a single query).

    select max(unit_price) as maximumunitprice,
           min(unit_price) as minimumunitprice,
           avg(unit_price) as averageunitprice
    from menu
    limit 5; 

--resulting table
--maximumunitprice	minimumunitprice	averageunitprice
--   60.0	                50.0	             55.0


-- Q7) Select order id, date, and delivery platform, but change any occurrence of the substring "Grab" to "Cougar";
-- HINT: Use the REPLACE function (https://app.datacamp.com/learn/tutorials/sql-replace)

select orderid, orderdate, replace (delivery_platform, 'Grab', 'Cougar') as delivery_platform
from orders
limit 5; 

--resulting table
-- orderid	orderdate	delivery_platform
-- 1	2022-08-01	Cougarfood
-- 2	2022-08-01	Lineman
-- 3	2022-08-02	Robinhood
-- 4	2022-08-03	Cougarfood
-- 5	2022-08-04	Robinhood

-- #### SECTION 3: Group By ####

-- Q8) Find the average, min, max order quantity by delivery platform
SELECT 
    delivery_platform,
    MAX(quantity) AS MaxQuantity,
    MIN(quantity) AS MinQuantity,
    AVG(quantity) AS AvgQuantity
FROM orders
GROUP BY delivery_platform
LIMIT 5;

--resulting table
--delivery_platform	MaxQuantity	MinQuantity	AvgQuantity
--Grabfood	3	1	1.5
--Lineman	3	1	2.0
--Robinhood	2	1	1.16666666666667


-- Q9) Find the number of orders by delivery platform, but filter to the delivery platform(s) with a count greater than five

SELECT delivery_platform, COUNT(orderid) as NumberofOrders
FROM orders
GROUP BY delivery_platform
HAVING COUNT(orderid) > 5

LIMIT 5;

--resulting table
--delivery_platform	NumberofOrders
--Grabfood	            12
--Robinhood	            6

-- Q10) Find the total number of units sold by the delivery platform
SELECT delivery_platform, COUNT(quantity) as UnitsSold
FROM orders
GROUP BY delivery_platform

LIMIT 5; 

--resulting table
--delivery_platform	UnitsSold
--Grabfood	12
--Lineman	5
--Robinhood	6

--if the question was building off question 9 it would be
SELECT delivery_platform, COUNT(orderid) as UnitsSold
FROM orders
GROUP BY delivery_platform
having COUNT(orderid) > 5

LIMIT 5; 

--resulting table
--delivery_platform	UnitsSold
--Grabfood	12
--Robinhood	6

-- #### SECTION 4: Joins ####

-- Q11) Get the order id, order quantity, customer id, customer first name, and customer last name for all orders
SELECT 
    o.orderid AS OrderID,
    o.quantity AS OrderQuantity,
    c.customer_id AS CustomerID,
    c.firstname AS CustomerFirstName,
    c.lastname AS CustomerLastName
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
LIMIT 5; 

--resulting table

--OrderID	OrderQuantity	CustomerID	CustomerFirstName	CustomerLastName
-- 1	1	4	Jeno	Lee
-- 2	2	1	Mark	Lee
-- 3	2	2	Johnny	Suh
-- 4	1	5	Karina	Yoo
-- 5	1	2	Johnny	Suh

-- Q12) Get the order id, order quantity, delivery platform, unit price and revenue (quantity * unit price) for all orders
SELECT 
    o.orderid AS OrderID,
    o.quantity AS OrderQuantity,
    o.delivery_platform AS DeliveryPlatform,
    m.unit_price AS UnitPrice,
    o.quantity * m.unit_price AS Revenue
FROM orders o
JOIN menu m
ON o.menu_id = m.menu_id
LIMIT 5;

--resulting table from inner join
--OrderID	OrderQuantity	DeliveryPlatform	UnitPrice	Revenue
--1	1	Grabfood	50.0	50.0
--2	2	Lineman	55.0	110.0
--3	2	Robinhood	50.0	100.0
--4	1	Grabfood	50.0	50.0
--5	1	Robinhood	50.0	50.0
