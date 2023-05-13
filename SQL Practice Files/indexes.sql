SELECT
	COUNT(DISTINCT LEFT(last_name, 1)),
    COUNT(DISTINCT LEFT(last_name, 5)),
    COUNT(DISTINCT LEFT(last_name, 10))
FROM customers;

SELECT DISTINCT LEFT(last_name, 5) FROM customers