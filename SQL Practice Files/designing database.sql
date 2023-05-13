-- Designing Databases using SQL queries

-- Creating Database
CREATE DATABASE IF NOT EXISTS sql_store2;
USE sql_store2;

-- Creating table
-- First we will drop the table if the table already exists
DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers
(
	customer_id 	INT,
    customer_name 	VARCHAR(50) NOT NULL,
    email 			VARCHAR(50) NOT NULL UNIQUE,
    phone 			VARCHAR(30)
);

-- ADDING FOREIGN KEY TO A CHILD TABLE
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders
(
	order_id 		INT,
    order_class 	INT NOT NULL,
    o_customer_id 	INT,
    order_date 		DATE,
    order_time 		TIME
);

-- ADDING FOREIGN AND PRIMARY KEY AFTER THE TABLES ARE CREATED
-- WE USE ALTER COMMAND TO ALTER TABLE STRUCTURES
ALTER TABLE customers
	ADD PRIMARY KEY customers (customer_id);

ALTER TABLE orders
	ADD PRIMARY KEY orders (order_id, order_class),
    ADD FOREIGN KEY fk_orders_customers (o_customer_id)
		REFERENCES customers (customer_id);

ALTER TABLE orders 
	DROP PRIMARY KEY,
    ADD PRIMARY KEY orders (order_id);

-- Character Set and Collation
/*
	Mysql convert each character in a give string into a numeric representaion to store data in the database.
    Mysql uses character set that supports characters of latin, middle east and asian languages. The default
    character set is UTF8 that supports characters of all international languages
    
    We can change charaset on db level, table level and column level to save up space in our db
	
    "SHOW CHARSET" shows all the character set that mysql supports
    
    COLLATION: collations are certain set of rules that determines the how the characters are sorted in a character set
    For example: the default collation set for UTF8 is utf8_general_ci. This collation sortes string regardless the uppercase
	and lowercase characters because it is case insensitive

*/

SHOW CHARSET;

USE medlink;

ALTER TABLE med_type
	ADD COLUMN new_char_set_col varchar(10) charset latin1;
    
    describe med_type;

ALTER DATABASE sql_store2
	CHARACTER SET latin1;

USE sql_store2;
ALTER TABLE customers character set latin1;

-- Storage Engines
/*
	Mysql comes with many storage engines. Each of them contains unique functionalities
    There are two types of storage engines transactional and non transactional stroage engines
    MyISAM is a non transactional store engine that was the standard in mysql prioir version 5.5
    Now, InnoDB is the standard transactional database. 
    
    InnoDB is the transactional storage engine. This engine supports many advanced functionalities
    like transactions and foreign keys.
*/ 

SHOW ENGINES;






