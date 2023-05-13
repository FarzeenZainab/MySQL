-- we can use function for the same purpose we are using stored procedure
-- the only difference between a function and a stored procedure is that function always returns
-- a singal value unlike stored procedure which can return multiple result set like rows and column

-- the syntax for defining a function in mysql is similar to stored procedure
-- we have some additional things to consider when define a function but the structure is same

-- function

delimiter $$
create function get_risk_factor_per_client()
RETURNS INT -- the data type in which the data which is returned on execution
BEGIN
	
return 1;
END $$
delimiter ;