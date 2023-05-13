-- A view is used to store the result of a complex query so we donot have to code them again
-- a view never stores data, our data is stored in our tables and views only shows the query result of an underlying table

use sql_invoicing;

create view sales_by_client AS
	select 
		client_id,
		name,
		SUM(invoice_total) as totals
	from clients
	join invoices 
		using(client_id)
	group by client_id;

-- exercise
-- create view to see the balance of each client

-- where balance is equal to total_sales - payment_total

create view client_total_balance as
select 
	client_id,
    name,
	SUM(invoice_total) - SUM(payment_total) AS balance
    from clients
    join invoices using(client_id)
    group by client_id;

select * from client_total_balance;

-- altering and dropping views
DROP VIEW client_total_balance;

create or replace view client_total_balance as
select 
	client_id,
    name,
	SUM(invoice_total) - SUM(payment_total) AS balance
    from clients
    join invoices using(client_id)
    group by client_id
    order by balance desc;

select * from client_total_balance;

-- Updatable views (insert update and delete statements)
-- there are certain conditions to make a view updatable
	-- view should not have a 
    -- DISTINCT Keyword
    -- aggregrate functions
    -- group by or having clause
    -- UNION

-- If above conditions are true than our views are updatable
-- create an updatble view and perform CRUD on it

create or replace view client_balance as
select 
	invoice_id,
	client_id,
    name,
    invoice_total,
    payment_total,
	invoice_total - payment_total AS balance
    from clients
    join invoices using(client_id)
    where invoice_total - payment_total > 0
    with check option;

 update client_balance
 set payment_total = invoice_total
 where invoice_id = 2;

select * from 
client_balance;

-- we lost all the data of client 1 because we have a condition in our view statement that is to only show those clients
-- whose balance is greater than 0
-- to avoid the data loss we can use the 'WITH CHECK OPTION' 
-- this option will prevent any rows to exclude when updation happens
drop view client_balance;
















