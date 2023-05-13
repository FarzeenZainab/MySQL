USE sql_store;

-- conditional operator in where clause
SELECT * FROM orders
WHERE order_date >= '2019-01-01';

-- we can add an alias column which can be a combination of more than one columns in the table,
-- this column is not an attribute of the table but we are returning a result set using SELECT statement
-- we can perform arthmetic operations, functions.
SELECT *,
quantity + unit_price AS 'total_price'
FROM order_items
WHERE order_id = 6 AND 'total_price' > 30;

-- concat() function used to select the complete address in one column
SELECT *,
concat(address, ' ', city, ' ', state) AS 'Address'
FROM customers
WHERE points > 1000 OR points < 2968
ORDER BY first_name ASC;

-- AND OR NOT
 SELECT *
 FROM order_items
 WHERE order_id = 6 AND quantity * unit_price > 30;
 
 -- IN operator is used when we want to compare an experession with a list of items
 -- to simplify column = condition1 OR column = condition_2 OR column = condition3
 -- we can write column IN (condition1, condition2, condition3)
 SELECT * FROM products WHERE quantity_in_stock IN (49, 38, 72);
 
 -- BETWEEN operator is used to compare an atribute with number range
 SELECT *
 FROM customers
 WHERE birth_date BETWEEN '1990/1/1' AND '2000/1/1';
 
 -- LIKE Operator is used to match a certain pattern in a string
 -- % any number of characters
 -- _ single character
 -- Example
 
 SELECT *
 FROM customers
 WHERE last_name LIKE 'R%y%';
 
 SELECT * 
 FROM customers
 WHERE address LIKE '%TRAIL%' OR address LIKE '%AVENUE%';
 
 SELECT *
 FROM customers
 WHERE phone LIKE '%9';
 
 -- if we want a certain pattern not to match we use NOT operator before LIKE
 -- Example
 
 SELECT * 
 FROM customers
 WHERE address NOT LIKE '%TRAIL%' AND address NOT LIKE '%AVENUE%';
 
 -- REGEXP (regular expression) used to write complex serch pattern in a string
 -- we have special characters that makes REGEXP more powerfull
 -- ^ caret indicated the beginning of a string
 -- $ indicates ending of a string
 -- | (pipe) logical OR use to search multiple values in a string
 -- [aefv]d matched ad, ed, fd, vd in a string, [] can be in the begining or in the end 
 -- [a-h]f matched a range of character with f
 
 -- EXERCISE

SELECT *
FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';

SELECT *
FROM customers
WHERE last_name REGEXP 'ey$|on$';

SELECT *
FROM customers
WHERE first_name REGEXP '^MY|SE';

SELECT *
FROM customers
WHERE first_name REGEXP 'b[ru]';

-- IS NULL operator is used to find records whose value is null or absent
 SELECT *
 FROM customers WHERE phone IS NULL;
 
 SELECT *
 FROM customers
 WHERE phone IS NOT NULL; 
 
 -- EXERCISE
 SELECT * 
 FROM orders
 WHERE shipped_date IS NULL OR shipper_id IS NULL;
 
 -- ORDER BY CLAUSE
 -- use to sort data in column
 -- can sort multiple column in one query
 
 -- EXERCISE
 SELECT * 
 FROM customers
 ORDER BY first_name ASC, last_name DESC;
 
 SELECT *,
 quantity + unit_price AS 'total_price'
 FROM order_items
 WHERE order_id = 2 ORDER BY total_price DESC;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 