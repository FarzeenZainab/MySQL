-- Numeric Function in SQL
-- 1. ROUND()
-- 2. FLOOR()
-- 3. CEILING()
-- 4. RAND()
-- 5. ABS()
SELECT FLOOR(9.85),
	CEIL(9.85), CEILING(9.85),
    ROUND(9.256448, 3),
    TRUNCATE(9.259787, 4),
    RAND(),
    ABS(-10.9);

-- More numeric functions are available for trignometry and geometry

-- String Functions
-- LENGTH()
-- LTRIM()
-- RTRIM()
-- LEFT()
-- RIGHT()
-- SUBSTRING()
-- LOCATE()
-- REPLACE()
-- CONCATE()
-- UPPPER()
-- LOWER()

SELECT *,
	LENGTH(first_name),
	LTRIM('                  sdfhdsf'),
    RTRIM('adasd       '),
	LEFT(first_name, 3),
    RIGHT(last_name, 3),
    UPPER(first_name),
    REPLACE(first_name, 'b', ' NEW ') -- 3 parameters -> 1. string, characters to replace, new characters that will replace
FROM customers;


-- Date and time functions in MySql
SELECT 
	YEAR(NOW()),
    MONTH(NOW()),
    DAY(NOW()),
    TIME(NOW()),
    HOUR(NOW()),
    MINUTE(NOW()),
    SECOND(NOW())  -- All of these functions returns integer values 
    ;

-- To get date and time in string we need to use these functions
SELECT
	DAYNAME(NOW()) AS DAY,
	MONTHNAME(NOW()) AS MONTH,
	DAY(NOW()) AS DATE,
    YEAR(NOW()) AS YEAR,
    TIME(NOW()) AS TIME,
	CURDATE(), CURTIME(); -- to get current date and time()
    
    SELECT EXTRACT(YEAR FROM NOW()); -- recommended method to use when working with date and time()


-- Return the order placed in the current year
SELECT *
FROM orders
WHERE YEAR(order_date) = EXTRACT(YEAR FROM NOW());

-- Date and Time Practice
SELECT date(NOW());
SELECT time(NOW());
SELECT CURDATE();
SELECT CURTIME();
SELECT YEAR(NOW());
SELECT MONTHNAME(NOW());
SELECT DAYNAME(NOW());
SELECT EXTRACT(DAY FROM NOW());
SELECT EXTRACT(YEAR FROM NOW());
SELECT EXTRACT(MONTH FROM NOW());
SELECT EXTRACT(HOUR FROM NOW());
SELECT EXTRACT(MINUTE FROM NOW());
SELECT EXTRACT(SECOND FROM NOW());
SELECT NOW();
SELECT WEEKOFYEAR(NOW());
SELECT DAYOFYEAR(NOW());
SELECT LAST_DAY(NOW());

-- formating dates and time for user friendly experience
-- mysql usually formats dates in yyyy-mm-dd format which is not user freindly
-- we will use some in-built functions to format our dates and time

-- 1. DATE_FORMAT() function. This function will format date using in built format specifiers
	-- %Y For four digit year 
    -- %y for 2 digit year
    -- %m for number month
    -- %M for string month
    -- %d for day of month
    -- %a weekday name
    Select date_format(NOW(), '%d %M %Y %a');
    select date_format(NOW(), '%D %m %y');
    
-- 2. TIME_FORMAT() function is used to format time in custom format
	-- specifiers for time 
    -- %H hour 0-23
	-- %h hour 0-12
    -- %i minutes
    -- %p for AM and PM
    
select time_format(NOW(), '%H:%i %p');
SELECT dayname(now());


-- CALCULATING DATE AND TIME
-- often time we need to calculate date and time to view results in our table
-- we have some functions that will calculate date and time
	-- date_add() returns additoin of the specified interval and the specified date (use to get a date in future)
    -- date_sub() returns the subtraction of specified interval and the specified date (use to get a date in past)
    -- datediff() returns the difference between two dates in number of days
    -- time_to_sec() returns the number of sec elapsed after midnight 

-- select the orders placed yesterday
SELECT *, date_sub(DATE(NOW()), INTERVAL 1 DAY)
FROM orders
WHERE order_date = date_sub(DATE(NOW()), INTERVAL 1 DAY);

-- select all orders place this week
-- we will use between operator

SELECT COUNT(order_id) as 'number of orders this week'
FROM orders
WHERE order_date BETWEEN date_sub(date(now()), interval 1 week) AND date(NOW());

-- select orders placed last week
-- select the dates of last week and when last week ends
-- use the between operator to get the number of orders

select * 
FROM orders
where order_date between
	date_sub(date(now()), interval 2 week)
    AND
    date_sub(date(now()), interval 1 week);
	
select ROUND((time_to_sec('13:00') - time_to_sec('09:00')) / 3600);

-- IFNULL() function returns the specified string if the value of a row is null
-- if the value of a row is null, COALESCE() function will return value of another column and if the value in the other column is also null then it will return the specified string

-- example
select order_id, IFNULL(comments, 'no comments') as comments
from orders;

select order_id, COALESCE(comments, shipper_id, 'not available')
FROM orders;

select
	concat(first_name,' ', last_name) as customer,
	IFNULL(phone, 'UNKNOWN') as phone
FROM customers;

-- The IF function
select DISTINCT product_id, p.name,
	(
	select COUNT(product_id)
	from order_items
	where product_id = o.product_id
    ) AS 'number_of_orders',
    IF(
    (
		select COUNT(product_id)
		from order_items
		where product_id = o.product_id
    ) > 1,
    'ordered many times',
    'once') AS frequency
from order_items o
JOIN products p
	USING(product_id);


select concat(first_name, ' ', last_name) AS Customer_name,
	case
		when points > 3000 then 'Gold'
		when points > 2000 then 'Silver'
		ELSE 'Bronze'
		END AS category,
	order_date,
	case
		when shipped_date IS NULL then 'Not shipped'
        when YEAR(shipped_date) = 2018 then 'Order shipped recently'
        when YEAR(shipped_date) = 2017 then 'Order shipped 2 year ago'
        END AS shippment_status
from customers c
JOIN orders o
	USING(customer_id)
order by points DESC;































    
    









































