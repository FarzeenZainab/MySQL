-- Inserting, Updating and Deleting data

USE sql_store;

-- Difference between VARCHAR() and CHAR() data type
-- VARCHAR() -> variable charachter
	-- It stores characters in a variable fashion, means if the limit of varchar is set to 50 character and the value that we need to store is 
    -- 20 charachters long, VARCHAR() will not allot extra 30 spaces to complete the limit, it will dynamically store the characters without wasting memory

-- CHAR() will not store values in a variable fashion, if the limit is set to 50 and the value we need to store is 20 characters long than the CHAR data type will
-- allot extra spaces to complete the declared limit. It will cause memory wastage

INSERT INTO customers
VALUES(DEFAULT, 'Sam', 'Hamberg', NULL, NULL, 'ashduda', 'asdasd', 'AS', DEFAULT);

SELECT * FROM customers;

INSERT INTO customers(first_name, last_name, address, city, state)
VALUES( 'Sam', 'Hamberg', 'ashdusadsda', 'as', 'er');

-- inserting hierarchial data in tables
INSERT INTO orders (customer_id, order_date, status)
	values(9, '2022-2-2', 1);

INSERT INTO order_items 
	VALUES(last_insert_id(), 2, 11, 43.21),
	(last_insert_id(), 3, 13, 4.21),
    (last_insert_id(), 1, 21, 23.21);
    
-- creating a copy of a table
	CREATE TABLE loyal_customers -- parent
		SELECT * FROM customers	-- sub query
        WHERE points > 1000;

-- a subquery is a part of parent query
	
    -- Exercise
    USE sql_invoicing;

	-- from invoices table create a table which have all the archieved orders
    -- the table should display client name and only those client should
    -- appear in the table who had made a payment
    
    CREATE TABLE invoices_archieved
		SELECT c.name, c.phone,
			   i.invoice_id,i.invoice_date, i.invoice_total, i.payment_total, i.payment_date,
			   p.amount AS 'payment_confirmed'
		FROM invoices i
		JOIN clients c
			USING(client_id)
		JOIN payments p
			USING(invoice_id)
		WHERE i.invoice_date < '2019-12-31';
        
	SELECT * FROM invoices_archieved;
	
USE sql_store;

UPDATE customers
SET points = points + 50
WHERE birth_date <= '1990-12-31';

SELECT * FROM customers;

-- updating multiple rows using sub queries

	UPDATE invoices 
    SET payment_total = invoice_total * 0.5
    WHERE client_id IN (
		SELECT client_id 
        FROM clients
        WHERE city IN ('Waltham', 'Orlando', 'Visalia', 'Chicago')
        );

-- select customer who have more than 3000 points
-- in orders table if the customer made an order
-- add comment as gold customer

	UPDATE orders 
    SET comments = 'Gold Customer'
    WHERE customer_id IN(
		SELECT customer_id FROM customers
		WHERE points > 200
    );
































