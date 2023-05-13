-- user defined variables are used when we want to store a value in mysql
-- It is just like storing a value in a variable like we do in JS or PHP
-- we use SET keyword to store value in a variable
-- and we prefix the variable name with @
-- we also use user-defined variables when using output paramerters 

set @first_name = 'Farzeen';
set @last_name = 'Zainab';

select @first_name, @last_name, concat(@first_name, ' ', @last_name) AS full_name;

-- The type of variable that mysql supports are local variable
-- these variables are defined inside a function or in a stored procedure
-- the value stored inside local variable stayes in the memory during the execution of a function or a procedure
-- after the execution the value is wiped out of the memory

-- we can declare the local variable by using DECLARE keyword 
-- as we can assign a value to a local variable using the INTO keyword

-- Example
-- calculate the risk factor using local variables
-- risk factor = invoice_total/ invoice_count * 5

drop procedure if exists get_risk_factor;

delimiter $$
create procedure get_risk_factor()
BEGIN
	-- declaring local variable
    DECLARE invoices_total decimal(9, 2) ;
    DECLARE invoices_count INT; 
    DECLARE risk_factor decimal(9, 2) default 0;
    
    select SUM(invoice_total), COUNT(invoice_total)
	INTO invoices_total, invoices_count
	from invoices;
    
	SET risk_factor = invoices_total / invoices_count * 5;
    select risk_factor;
     
END $$
delimiter ;

call get_risk_factor;
























