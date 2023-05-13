-- stored procedure is a block of code that is executed as one unit to perform a particular task

DELIMITER $$
CREATE PROCEDURE select_customers()
BEGIN
	select * from customers; -- body of the stored procedure
END$$
DELIMITER ;

call select_customers();


-- create a stored procedure that have all the invoices and balance greater than zero

use sql_invoicing;

delimiter $$
create procedure get_invoices_with_balance()
begin
	select *, invoice_total - payment_total as balance
	from invoices 
	where invoice_total - payment_total > 0;
end$$

drop procedure if exists `get_clients_with_invoices`$$
use sql_invoicing$$

create procedure get_clients_with_invoices()
begin
	select client_id, name
    from clients
    where client_id IN (
		select DISTINCT client_id 
        from invoices
    );
end$$
delimiter ;

call get_invoices_with_balance();
call get_clients_with_invoices();


-- create a procedure that shows the products that have not been ordered, use sql_store

DELIMITER $$
USE sql_store$$
DROP PROCEDURE IF EXISTS products_not_ordered$$
CREATE PROCEDURE products_not_ordered()
BEGIN
	SELECT * 
	FROM products p where NOT EXISTS (
		SELECT DISTINCT product_id
		FROM order_items o
		where o.product_id = p.product_id
	);
END$$
DELIMITER ;
call products_not_ordered;

-- Parameterized stored procedure 
-- we use parameterized stored procedure to pass in or out the values to our stored procedure
-- write a procedure to get the invoices of a given client

delimiter $$
use sql_invoicing$$
drop procedure if exists get_invoices_by_clients$$
create procedure get_invoices_by_clients(client_id int)
BEGIN
	select * from invoices i
	where i.client_id = client_id;
END$$
delimiter ;

call get_invoices_by_clients(5);

-- write a stored procedure to get all the employees working in a given office
-- always give the data type of the parameter in stored procedure

drop procedure if exists get_employees_of_an_office;
use sql_hr;

delimiter $$
create procedure get_employees_of_an_office(office_id INT)
BEGIN
	select 
		e.office_id,
		concat(first_name, last_name) as Employee,
		job_title,
		state,
		address
	from employees e
	join offices o
		using(office_id)
	where e.office_id = office_id;
END $$
delimiter ;

-- Default value in a stored procedure
-- we can pass in a default procedure if the value is not supplied to the paramerter as an argument
-- we can use if-else statements
-- if-else statement is different from IF() and IFNULL() function
-- here case is an operator not a statement like switch

select *,
	case 
		when office_id > 3 then 'secondary'
		when office_id >= 1 then 'main'
        end AS office_type
 from  offices;

-- if and if else statement in mysql can only be used inside a procedure
-- create a procedure in which select all the customers from customers table by passing the birth_date year as a parameter
-- if no argument is passed then show all the customers in customers table
-- first use if else statement and then use a simplfied version

use sql_store;

delimiter $$

-- procedure 1 (null value can not be passed)
create procedure get_customers_by_birth_year(birth_year INT)
begin 
	select * 
    from customers c
    where YEAR(c.birth_date) = birth_year;
end $$

-- procedure 2 (null value can be passed --> procedure will show the customers born in year 1986--> using IF statement)
drop procedure if exists get_customers_by_birth_year_1;
create procedure get_customers_by_birth_year_1(birth_year INT)
begin 
	if birth_year IS NULL then
		set birth_year =  1986;
        -- select * from customers
		select * 
		from customers c
		where YEAR(c.birth_date) = birth_year;
	end if;
end $$

drop procedure if exists  get_customers_by_birth_year_2;

create procedure get_customers_by_birth_year_2(birth_year INT)
begin 
	if birth_year IS NULL then
		select 'please enter birth_year' as 'ERROR';
	elseif birth_year >= 1986 then
		select *, 
        'Hello World' as Greetings 
		from customers c
		where YEAR(c.birth_date) = birth_year;
     else   
        select *
		from customers c
		where YEAR(c.birth_date) = birth_year;
	end if;
end $$

-- simplified way of doing the same thing by using the ifnull() function
drop procedure if exists get_customers_by_birth_year_3;

create procedure get_customers_by_birth_year_3(birth_year INT)
begin 
  select *
  from customers c
  where YEAR(c.birth_date) = IF(birth_year IS NULL, YEAR(c.birth_date), birth_year);
end $$

delimiter ;

call get_customers_by_birth_year(1985);
call get_customers_by_birth_year_1(NULL);
call get_customers_by_birth_year_2(1986);
call get_customers_by_birth_year_3(NULL);


-- parameter validation is essential before executing procedure to avoid bad data being stored in our database
-- we can do data validation by using signal keyword to show an error on the time of execution, this signal will show a
-- error message that will have and sqlstate error code

-- inside our invoices table we need to insert a new invoice
-- to do that we need to provide following parameters
	-- invoice_id, number, client_id, invoice_total, payment_total, invoice_date, due_date, payment_date
    -- validate client_id, payment_total, 
	-- check if we have a client_id in our clients' table and check if the payment total amount is not a negative number

drop procedure if exists generate_new_invoice;
delimiter $$
create procedure generate_new_invoice
(
	p_invoice_id INT,
    p_number VARCHAR(50),
    p_client_id INT,
    p_invoice_total decimal(9,2),
    p_payment_total decimal(9,2),
    p_invoice_date date,
    p_due_date date,
    p_payment_date date
)
BEGIN
	-- parameter validation
	-- client_id validation is not required because it is a foreign key and it will not execute if the row  is not present in the parent table with the given id
	
    -- paymeny_total 
	IF p_payment_total < 0 OR p_invoice_total < 0 THEN
    SIGNAL SQLSTATE '22003' SET MESSAGE_TEXT = 'Invalid Payment Amount';
    END IF;

	INSERT INTO invoices(invoice_id, number, client_id, invoice_total, payment_total, invoice_date, due_date, payment_date)
		VALUES(
			 p_invoice_id, p_number, p_client_id, p_invoice_total, p_payment_total, p_invoice_date, p_due_date, p_payment_date
        );
END$$

delimiter ;

-- Write a stored procedure for practice

use sql_store;

drop procedure if exists get_customers_by_state;
delimiter $$
create procedure get_customers_by_state(state varchar(4))
begin
	IF state is null then
    set state = 'MA';
    END IF;
    
	select first_name, last_name
    from customers c
    where c.state = state;
end $$
delimiter ;


















































































