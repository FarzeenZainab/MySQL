-- Write a query to find the product which are more expensive then lettuce (id = 3)
USE sql_store;

SELECT *
FROM products 
WHERE unit_price > (
		SELECT unit_price FROM 
        products WHERE product_id = 3
    );
    
-- Exercise
-- in sql_hr
-- Find employee who earn more than average 
	-- First we need to calculate the average salary of employees
	-- After that we need to select all those clients that earn more than average

USE sql_hr;

SELECT * 
FROM employees
WHERE salary > (
	SELECT AVG(salary) AS average_salary
	FROM employees
    );

USE sql_store;

SELECT * FROM 
products WHERE product_id NOT IN (
	SELECT DISTINCT product_id 
	FROM order_items
);

-- write a query to find a client without invoices
USE sql_invoicing;

SELECT * 
FROM clients WHERE client_id NOT IN (
	SELECT DISTINCT client_id
	FROM invoices
);

-- Find the customers who have ordered lettuce (id = 3)
-- Select customer_id, firstname and lastname

-- using a subquery
	USE sql_store;

	-- select order items with lettuce
    -- get the customer_id where order_id is 

-- using sub query
SELECT customer_id, first_name, last_name
FROM customers
  WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM orders
    WHERE order_id IN (
		-- select order_id from order items table who have lettuce
		SELECT order_id 
		FROM order_items
		WHERE product_id = 3
	)
);

-- Using Join
SELECT DISTINCT o.customer_id, oi.product_id, c.first_name, c.last_name
FROM orders o
JOIN order_items oi
	USING(order_id)
JOIN customers c
	USING(customer_id)
WHERE product_id = 3
;

-- Select the invoices that are larger than the invoices of client 3
USE sql_invoicing;

SELECT *
FROM invoices
WHERE invoice_total > (
	SELECT MAX(invoice_total)
	FROM invoices
	WHERE client_id = 3
);

-- There is another way of doing the same thing
-- We can use the ALL keyword to solve this problem

-- ALL keywork will match expression to every value in the list and when all conditions are true than it will return the result
-- ALL expression is equivalent to expression >= condition1 AND condition2 AND condition3

SELECT *
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total
	FROM invoices
	WHERE client_id = 3
);

-- ANY keywork will match expression to every value in the list and when all conditions are true than it will return the result
-- ANY expression is equivalent to expression >= condition1 OR condition2 OR condition3

SELECT *
FROM invoices
WHERE invoice_total > ANY (
	SELECT invoice_total
	FROM invoices
	WHERE client_id = 3
);


-- Select the employees that have the salary above average in their office

-- Correlated subquery
-- Find the employees earning more than average in their office
-- we need to calculate the average salar of each office
-- and compare it with each employee

USE sql_hr;

SELECT * 
FROM employees e
WHERE salary > ( -- compare it with employee
	SELECT AVG(salary) 
    FROM employees -- calculate salary of office 3
    WHERE office_id = e.office_id -- 3
);

-- Exercise
	-- get invoices larger than the invoice of
    -- client's average invoice

USE sql_invoicing;

SELECT * 
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total) -- average invoice_total of client 3
    FROM invoices
    WHERE client_id = i.client_id -- 3
    );
    
-- select client who have an invoice in the invoices table using a sub query
	SELECT * FROM clients
    WHERE client_id IN (
		SELECT DISTINCT client_id
        FROM invoices 
    );

-- third way of this is
SELECT * 
FROM clients
WHERE EXISTS (
	SELECT *
    FROM invoices
    WHERE client_id = clients.client_id
);

-- EXISTS keywork evalutes the expression and result TRUE or FALSE based on the evaluation
-- This keywork is very useful when the IN operator is returning hundreds or thousand of row in the result set
-- This slows down the process of exuction so we use EXISTS keyword
-- It will evalute the specified expression for each row and if the condition is satisfied it will return 
-- the row in the result set

-- Excersice 
-- get the clients that have an invoice

-- we can do it using IN operator in subquery
USE sql_invoicing;
SELECT *
FROM clients
WHERE client_id IN (
	SELECT DISTINCT client_id 
	FROM invoices
    );

-- Now imagine if we have thousands of clients who have invoice generated
-- So our subquery will return a result set based on thousand rows which will take time to execute
-- To reduce the execution time we will use the EXISTS keyword which will compare each row and
-- will return the client who have an invoice
-- EXISTS can be used in correlated subqueries

SELECT *
FROM clients c
WHERE NOT EXISTS (
	SELECT DISTINCT client_id 
	FROM invoices
    WHERE client_id = c.client_id -- 1
);

-- Find the porducts that have never been ordered
-- THink it like you are writing subquery for AMAZON where we have million of products on the website
-- find the most optimized way to get the result

-- USING IN operator
SELECT * 
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id 
	FROM order_items
);

-- EXISTS keyword
SELECT * 
FROM products p
WHERE NOT EXISTS (
	SELECT DISTINCT product_id
    FROM order_items 
    WHERE product_id = p.product_id
);

-- We can write a subquery in SELECT clause as well as the from clause
SELECT invoice_id,
	invoice_total,
	(SELECT AVG(invoice_total) FROM invoices) AS Average,
    invoice_total - (SELECT Average) AS difference
FROM invoices;

-- Produce the result
SELECT 
	client_id,
    name,
    (
		SELECT SUM(invoice_total) -- sum of all the sales issued of each client
        FROM invoices
		WHERE client_id = c.client_id
    ) AS total_sales,
    (
		SELECT AVG(invoice_total) -- avg sales in invoices table
        FROM invoices
	) AS AVG_sales,
    (SELECT total_sales) - (SELECT AVG_sales) AS Difference
 FROM clients c


















