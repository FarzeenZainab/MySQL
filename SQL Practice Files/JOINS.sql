USE sql_store;

-- Joins are use to join two or more tables to view complete data in tables which have relationship between them

SELECT OI.order_id, OI.product_id, P.name, OI.quantity, OI.unit_price, OI.quantity + OI.unit_price AS 'Total Price'
FROM order_items OI
JOIN products P 
	 ON OI.product_id = P.product_id
	 -- WHERE P.product_id IN (1,2,3)
     ;

SELECT * 
FROM order_items oi
JOIN sql_inventory.products p
	 ON oi.product_id = p.product_id;
     
-- If sql_inventory DB is selected, we need to prefix the order_items table with its database

USE sql_inventory;
 
SELECT * 
FROM sql_store.order_items oi
JOIN sql_inventory.products p
	 ON oi.product_id = p.product_id;   

-- SELF JOINS
-- A self join is regular join, but the table is joined with itself- this is
-- extremely useful for comparisons with in a table
-- Example:

USE sql_hr;

SELECT *
FROM employees emp
JOIN employees manager
	ON emp.reports_to = manager.employee_id
    WHERE manager.employee_id = 37270;

USE sql_store;

-- Exercise 
-- Create a join to view the order, which customer placed the order and what is the status of the order
-- Also which product is ordered its quantity and total price should come

SELECT o.order_id,
	c.first_name,
	c.last_name,
	os.name AS 'status',
	p.name,
	oi.unit_price,
	oi.quantity,
    oi.unit_price * oi.quantity AS 'Total Amount'
FROM orders o
JOIN customers c
	 ON c.customer_id = o.customer_id
JOIN order_statuses os
	 ON o.status = os.order_status_id
JOIN order_items oi
	 ON o.order_id = oi.order_id
JOIN products p
	 ON p.product_id = oi.product_id
;
    
-- Exercise

USE sql_invoicing;

SELECT
	i.invoice_id, 
	c.name,
    c.phone,
    i.invoice_total,
    i.invoice_date,
    p.amount AS 'amount_paid',
    pm.name
FROM clients c
LEFT JOIN invoices i
	ON i.client_id = c.client_id
LEFT JOIN payments p
	ON p.invoice_id = i.invoice_id
LEFT JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
;
    
    
-- View payments maid by our customers

USE sql_invoicing;

SELECT p.payment_id, c.name, i.number AS 'invoice number', i.payment_total, i.invoice_total, pm.name
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN invoices i
	ON p.invoice_id = i.invoice_id
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method
    ;

-- OUTER JOINS
-- Previously when using an inner join we are getting the results which matches the condition of the ON statement
-- which means only those records are returned in the result set whose id is present in the other table
-- In many cases we want to see the unmatched records to analyze our data better, in order to do that
-- we need to use a outer join
-- there are two types of outer joins
	-- 1. left join
    -- 2. right join


-- exercise 
USE sql_store;

-- Select all the product whether its order has been made or not
SELECT * 
FROM products p
LEFT JOIN order_items oi
 ON p.product_id = oi.product_id;
    
-- OUTER JOIN Exercise
SELECT  o.order_date,
		o.order_id, 
        c.first_name,
        s.name,
        os.name
FROM customers c
INNER JOIN  orders o
	ON o.customer_id = c.customer_id
LEFT JOIN shippers s
	ON s.shipper_id = o.shipper_id
JOIN order_statuses os  
	ON os.order_status_id = o.status
    ORDER BY s.name;

-- The USING CLAUSE
-- The using clause is used to simply our ON expression in JOIN syntax
-- we can use USING clause when we have the same column name of the relationship coulmns in both of our tables
-- we can replace it with the USING keyword

-- Example
SELECT * 
FROM order_item_notes ois
JOIN order_items oi 
	ON (oi.order_id = ois.order_id AND
    oi.product_id = ois.product_id)
    ;

SELECT * 
FROM order_item_notes ois
JOIN order_items oi 
	USING(product_id, order_id)
    ;

-- Exercise
USE sql_invoicing;

SELECT 
	p.date,
    c.name AS 'client',
    p.amount,
    pm.name
FROM payments p 
JOIN clients c
	USING(client_id)
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method
ORDER BY p.amount ASC;
	
USE sql_store;
SELECT * FROM products, shippers;

SELECT * FROM products cross join shippers;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    