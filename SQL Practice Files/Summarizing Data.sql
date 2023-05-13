-- Aggregriate Functions
-- Max()
-- Min()
-- Sum()
-- Count()
-- Avg()
-- These are the functions used to summarize data

-- These function returns the summarized data of a column in a table
USE sql_invoicing;
SELECT
	SUM(payment_total) AS 'Total',
    MAX(payment_total) AS 'Max Total',
    MIN(payment_total) AS 'Min Value',
    AVG(payment_total) AS 'Average',
    Count(payment_total) AS 'count'
 FROM invoices;

-- We can apply these functions on strings and values also
SELECT
    MAX(payment_date) AS 'Highest date',
    MIN(payment_date) AS 'Lowest Date',
    Count(payment_date) AS 'count'
 FROM invoices;

-- These function donot work on NULL values, we can count data irrespective to the NULL values in rows by using COUNT(*)
-- Example
SELECT
    Count(*) AS 'count'
 FROM invoices;

-- we can also pass expression in these function
-- Example
SELECT
	SUM(payment_total) AS 'Total',
   SUM(payment_total * 8) AS 'Expression Result'
 FROM invoices;

-- In the above example the function will first multiply every row in payment_total with 
-- 8 and then SUM all the rows to calculate the result

-- We can also use these functions using WHERE clause to filter out specific data
-- We use DISTINCT keyword to return non repeating data example client 

-- Exercise

SELECT 
	'First Half of 2019' AS date_range,
	SUM(invoice_total) AS 'total_sales',
    SUM(payment_total) AS 'total_payment',
    SUM(invoice_total - payment_total) AS 'what_we_expect'
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT 
	'Second Half of 2019' AS date_range,
	SUM(invoice_total) AS 'total_sales',
    SUM(payment_total) AS 'total_payment',
    SUM(invoice_total - payment_total) AS 'what_we_expect'
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT 
	'Total' AS date_range,
	SUM(invoice_total) AS 'total_sales',
    SUM(payment_total) AS 'total_payment',
    SUM(invoice_total - payment_total) AS 'what_we_expect'
FROM invoices;

-- Group by clause groups result set by specified columns
-- the data can be group using single or multiple coulmns
-- the order of the where, group by and order by clause matters

SELECT i.client_id, c.name, c.state, c.city
FROM invoices i 
JOIN clients c
	USING(client_id)
GROUP BY state, city;

SELECT 
	p.date,
	pm.name,
    SUM(p.amount) AS total_payments
FROM payments p
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
GROUP BY p.date, pm.name
ORDER BY p.date, amount DESC ;















